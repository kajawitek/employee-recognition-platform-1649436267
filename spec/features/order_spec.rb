require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order spec', type: :feature do
  let!(:reward) { create(:reward, price: 10) }
  let!(:employee) { create(:employee, number_of_available_points: 11) }
  let!(:order) { build(:order) }
  let!(:admin) { create(:admin) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'tests orders' do
    # showing a lower number of points after buying a reward
    click_link 'Buy'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 1'

    # seeing bought rewards list by employees
    click_link 'My orders'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.description
    expect(page).to have_content order.purchase_price
    expect(page).to have_content order.created_at

    # checking if changing reward price does not affect the price in list of bought rewards
    using_session('receiver session') do
      login_as admin, scope: :admin
      visit admins_rewards_path
      click_link 'Edit'
      fill_in 'reward[price]', with: '8'
      click_button 'Update Reward'
      expect(page).to have_content 'Reward was successfully updated.'
    end
    click_link 'My orders'
    expect(page).to have_content '10'
  end
end
