# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'OnlineCode spec', type: :feature do
  let!(:reward) { create(:reward, 'online', number_of_available_items: 3) }
  let!(:online_code) { build(:online_code, reward: reward) }
  let!(:online_code2) { create(:online_code, reward: reward) }
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee, number_of_available_points: 10) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'creates online code for online reward' do
    expect(OnlineCode.count).to eq 1

    click_link 'Online codes'
    click_link 'New Online Code'
    select reward.title, from: 'online_code[reward_id]'
    click_button 'Create Online code'
    expect(page).to have_content 'Online code was created.'

    expect(OnlineCode.count).to eq 2
    expect(reward.online_codes.count).to eq 2
  end

  it 'lists online code in index view' do
    click_link 'Online codes'
    expect(page).to have_content online_code2.code
    expect(page).to have_content online_code2.reward.title
  end

  it 'uses online code only once' do
    expect(reward.online_codes.available.count).to eq 1
    expect(Reward.count).to eq 1

    using_session('employee session') do
      login_as employee, scope: :employee
      visit root_path
      click_link 'Rewards'
      click_link 'Buy'
      click_button 'Create Order'
      expect(page).to have_content 'Order was successfully created.'

      expect(reward.online_codes.available.count).to eq 0
      expect(Reward.count).to eq 1

      click_link 'Rewards'
      expect(page).to have_no_content 'reward.title'
    end
  end
end
