# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Reward spec', type: :feature do
  let!(:reward_online) { create(:reward, delivery_method: 'online', price: 1, number_of_available_items: 3) }
  let!(:online_code) { create(:online_code, reward: reward_online) }
  let!(:reward_post) { create(:reward, delivery_method: 'post', number_of_available_items: 1, price: 2) }
  let!(:reward_online_not_availble) { create(:reward, delivery_method: 'online', price: 3, number_of_available_items: 0) }
  let!(:reward_post_not_availble) { create(:reward, delivery_method: 'post', price: 4) }
  let!(:employee) { create(:employee) }

  before do
    login_as employee, scope: :employee
    visit root_path
  end

  it 'index and show rewards for employee users' do
    # listing rewards by employees
    click_link 'Rewards'
    expect(Reward.all.count).to eq 4
    expect(page).to have_content reward_online.title
    expect(page).to have_content reward_online.price
    expect(page).to have_content reward_online.description

    expect(page).to have_content reward_post.title
    expect(page).to have_content reward_post.price
    expect(page).to have_content reward_post.description

    find(:xpath, "//tr[td[contains(.,'post')]]/td/a", text: 'Show').click
    expect(page).to have_content reward_post.title
    expect(page).to have_content reward_post.price
    expect(page).to have_content reward_post.description
    expect(page).to have_link 'Back'
    click_link 'Back'

    find(:xpath, "//tr[td[contains(.,'online')]]/td/a", text: 'Show').click
    expect(page).to have_content reward_online.title
    expect(page).to have_content reward_online.price
    expect(page).to have_content reward_online.description
    expect(page).to have_link 'Back'
  end

  it "doesn't index rewards which aren't available" do
    click_link 'Rewards'
    expect(Reward.all.count).to eq 4
    expect(page).not_to have_content reward_online_not_availble.title
    expect(page).not_to have_content reward_online_not_availble.price
    expect(page).not_to have_content reward_online_not_availble.description

    expect(page).not_to have_content reward_post_not_availble.title
    expect(page).not_to have_content reward_post_not_availble.price
  end
end
