require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order filter spec', type: :feature do
  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin) }
  let!(:order_post) { create(:order, employee: employee, reward: create(:reward, :post)) }
  let!(:order_online) { create(:order, employee: employee, reward: create(:reward, :online), delivery_status: :delivered) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'tests filtering orders' do
    click_link 'My orders'
    click_link 'Not delivered'
    expect(page).to have_content order_post.reward.title
    expect(page).to have_content order_post.reward.description
    expect(page).to have_no_content order_online.reward.title
    expect(page).to have_no_content order_online.reward.description

    using_session('admin session') do
      login_as admin, scope: :admin
      visit admins_root_path
      click_link 'Orders'
      click_link 'Deliver'
      expect(page).to have_content 'Order was successfully delivered.'
    end

    click_link 'Delivered'
    expect(page).to have_content order_post.reward.title
    expect(page).to have_content order_post.reward.description
    expect(page).to have_content order_online.reward.title
    expect(page).to have_content order_online.reward.description

    click_link 'Not delivered'
    expect(page).not_to have_content order_post.reward.title
    expect(page).not_to have_content order_post.reward.description
    expect(page).not_to have_content order_online.reward.title
    expect(page).not_to have_content order_online.reward.description

    click_link 'All'
    expect(page).to have_content order_post.reward.title
    expect(page).to have_content order_post.reward.description
    expect(page).to have_content order_online.reward.title
    expect(page).to have_content order_online.reward.description
  end
end
