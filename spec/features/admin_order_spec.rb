require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin order spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let!(:order_post) { create(:order, reward: create(:reward, :post), employee: employee) }
  let!(:order_pick_up) { create(:order, reward: create(:reward, :pick_up), employee: employee) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it "tests if admin sees employee's bought rewards list" do
    click_link 'Employees'
    expect(page).to have_content order_post.employee.email
    expect(page).to have_content order_post.employee.number_of_available_kudos

    click_link 'Show'
    expect(page).to have_content order_post.employee.email
    expect(page).to have_content order_post.reward.title
    expect(page).to have_content order_post.reward.description
    expect(page).to have_content time_ago_in_words(order_post.created_at)
    expect(page).to have_content order_post.purchase_price
  end

  it 'tests admin delivering and order' do
    click_link 'Orders'

    expect(page).to have_content order_post.employee.full_name
    expect(page).to have_content order_post.reward.title
    expect(page).to have_content order_post.reward.description
    expect(page).to have_content time_ago_in_words(order_post.created_at)
    expect(page).to have_content order_post.purchase_price
    expect(page).to have_content order_post.delivery_status.humanize

    click_link 'Deliver'
    expect(page).to have_content 'Order was successfully delivered.'
    expect(page).not_to have_content('Deliver, link')
  end

  it 'tests admin preparing and delivering pick-up rewards' do
    click_link 'Orders'

    expect(page).to have_content order_pick_up.employee.full_name
    expect(page).to have_content order_pick_up.reward.title
    expect(page).to have_content order_pick_up.reward.description
    expect(page).to have_content time_ago_in_words(order_pick_up.created_at)
    expect(page).to have_content order_pick_up.purchase_price
    expect(page).to have_content order_pick_up.delivery_status.humanize

    click_link 'Ready for pick-up'
    expect(page).to have_content 'Pick-up instruction sent!'
    expect(page).not_to have_content('Ready for pick-up, link')

    find(:xpath, "//tr[td[contains(.,'Ready for pick up')]]/td/a", text: 'Deliver').click
    expect(page).to have_content 'Order was successfully delivered.'
    expect(page).not_to have_content('Deliver, link')
  end
end
