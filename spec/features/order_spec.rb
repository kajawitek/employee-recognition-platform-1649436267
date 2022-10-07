require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order spec', type: :feature do
  let!(:reward) { create(:reward, price: 10, delivery_method: 'post') }
  let!(:reward2) { create(:reward, price: 1, delivery_method: 'online') }
  let!(:address) { create(:address) }
  let!(:employee) { create(:employee, number_of_available_points: 21, address: address) }
  let!(:admin) { create(:admin) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'tests orders' do
    # showing a lower number of points after buying a reward with online delivery method
    find(:xpath, "//tr[td[contains(.,'online')]]/td/a", text: 'Buy').click
    click_button 'Create Order'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 20'

    # showing a lower number of points after buying a reward with post delivery method
    click_link 'Rewards'
    find(:xpath, "//tr[td[contains(.,'post')]]/td/a", text: 'Buy').click
    fill_in 'address[street]', with: employee.address.street
    fill_in 'address[postcode]', with: employee.address.postcode
    fill_in 'address[city]', with: employee.address.city
    click_button 'Create Order'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 10'

    # showing saved address for second purchase
    click_link 'Rewards'
    find(:xpath, "//tr[td[contains(.,'post')]]/td/a", text: 'Buy').click
    expect(page).to have_field('address[street]', with: employee.address.street)
    expect(page).to have_field('address[postcode]', with: employee.address.postcode)
    expect(page).to have_field('address[city]', with: employee.address.city)

    # seeing bought rewards list by employees
    click_link 'My orders'
    expect(page).to have_content reward.title
    expect(page).to have_content reward2.title
    expect(page).to have_content reward.description
    expect(page).to have_content reward2.description
    expect(page).to have_content Order.where(reward: reward).last.purchase_price
    expect(page).to have_content Order.where(reward: reward2).last.purchase_price
    expect(page).to have_content time_ago_in_words(Order.where(reward: reward).last.created_at)
    expect(page).to have_content time_ago_in_words(Order.where(reward: reward2).last.created_at)

    # checking if changing reward price does not affect the price in list of bought rewards
    using_session('admin session') do
      login_as admin, scope: :admin
      visit admins_rewards_path
      find(:xpath, "//tr[td[contains(.,'#{reward.title}')]]/td/a", text: 'Edit').click
      fill_in 'reward[price]', with: '8'
      click_button 'Update Reward'
      expect(page).to have_content 'Reward was successfully updated.'
    end
    click_link 'My orders'
    expect(page).to have_content '10'
  end
end
