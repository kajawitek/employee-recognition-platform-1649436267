require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order spec', type: :feature do
  let!(:reward) { create(:reward, :post, price: 10, number_of_available_items: 1) }
  let!(:reward2) { create(:reward, :online, price: 1) }
  let!(:online_code) { create(:online_code, reward: reward2) }
  let!(:address) { create(:address) }
  let!(:employee) { create(:employee, number_of_available_points: 21, address: address) }
  let!(:admin) { create(:admin) }

  before do
    login_as employee, scope: :employee
    visit root_path
  end

  it 'tests orders' do
    # showing a lower number of points and reward availabilty after buying a reward with online delivery method
    click_link 'Rewards'
    expect(page).to have_content reward2.title
    find(:xpath, "//tr[td[contains(.,'Online')]]/td/a", text: 'Buy').click
    click_button 'Create Order'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 20'
    click_link 'Rewards'
    expect(page).to have_no_content reward2.title
    expect(reward2.orders.last.delivery_status).to eq 'delivered'

    # showing a lower number of points reward availabilty after buying a reward with post delivery method
    expect(page).to have_content reward.title
    find(:xpath, "//tr[td[contains(.,'Post')]]/td/a", text: 'Buy').click
    fill_in 'address[street]', with: employee.address.street
    fill_in 'address[postcode]', with: employee.address.postcode
    fill_in 'address[city]', with: employee.address.city
    click_button 'Create Order'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 10'

    using_session('admin session') do
      login_as admin, scope: :admin
      visit admins_orders_path
      find(:xpath, "//tr[td[contains(.,'#{reward.title}')]]/td/a", text: 'Deliver').click
      expect(page).to have_content 'Order was successfully delivered.'
    end
    click_link 'Rewards'
    expect(page).to have_no_content reward.title

    # showing saved address for second purchase
    create(:reward, :post, price: 10, number_of_available_items: 1)
    click_link 'Rewards'
    find(:xpath, "//tr[td[contains(.,'Post')]]/td/a", text: 'Buy').click
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
