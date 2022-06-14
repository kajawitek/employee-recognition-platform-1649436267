require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Reward spec', type: :feature do
  let!(:reward) { create(:reward) }
  let!(:employee) { create(:employee) }

  before do
    login_as employee, scope: :employee
    visit root_path
  end

  it 'index and show rewards for employee user' do
    click_link 'Rewards'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content reward.description
    expect(page).to have_link 'Show'

    click_link 'Show'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price
    expect(page).to have_content reward.description
    expect(page).to have_link 'Back'
  end
end
