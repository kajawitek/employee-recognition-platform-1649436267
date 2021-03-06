require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin order spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:order) { create(:order) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it "tests if admin sees employee's bought rewards list" do
    click_link 'Employees'
    expect(page).to have_content order.employee.email
    expect(page).to have_content order.employee.number_of_available_kudos

    click_link 'Show'
    expect(page).to have_content order.employee.email
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content time_ago_in_words(order.created_at)
    expect(page).to have_content order.purchase_price
  end
  # There's a system spec for admin delivering an order

  it 'tests admin delivering and order' do
    click_link 'Orders'
    expect(page).to have_content order.employee.email
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content time_ago_in_words(order.created_at)
    expect(page).to have_content order.purchase_price
    expect(page).to have_content order.delivery_status

    click_link 'Deliver'
    expect(page).to have_content 'Order was successfully delivered.'

    click_link 'Deliver'
    expect(page).to have_content "You can't deliver this order again."
  end
end
