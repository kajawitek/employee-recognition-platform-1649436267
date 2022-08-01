require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order filter spec', type: :feature do
  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin) }
  let!(:order) { create(:order, employee: employee) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'tests filtering orders' do
    click_link 'My orders'
    click_link 'Not delivered'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content order.purchase_price
    expect(page).to have_content time_ago_in_words(order.created_at)

    using_session('admin session') do
      login_as admin, scope: :admin
      visit admins_root_path
      click_link 'Orders'
      click_link 'Deliver'
      expect(page).to have_content 'Order was successfully delivered.'
    end

    click_link 'Delivered'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content order.purchase_price
    expect(page).to have_content time_ago_in_words(order.created_at)

    click_link 'Not delivered'
    expect(page).not_to have_content order.reward.title
    expect(page).not_to have_content order.reward.description
    expect(page).not_to have_content order.purchase_price
    expect(page).not_to have_content time_ago_in_words(order.created_at)

    click_link 'All'
    expect(page).to have_content order.reward.title
    expect(page).to have_content order.reward.description
    expect(page).to have_content order.purchase_price
    expect(page).to have_content time_ago_in_words(order.created_at)
  end
end
