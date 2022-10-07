require 'rails_helper'
RSpec.describe 'Admin exporting order spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:order1) { create(:order) }
  let!(:order2) { create(:order) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'tests admin exporting orders to csv' do
    click_link 'Orders'
    click_link 'Export'

    csv = CSV.parse(page.body)
    expect(csv).to have_content order1.delivery_status
    expect(csv).to have_content order2.delivery_status
    expect(csv).to have_content order1.reward.delivery_method
    expect(csv).to have_content order2.reward.delivery_method
    expect(csv).to have_content order1.id
    expect(csv).to have_content order2.id
    expect(csv).to have_content order1.reward.id
    expect(csv).to have_content order2.reward.id
    expect(csv).to have_content order1.reward.title
    expect(csv).to have_content order2.reward.title
    expect(csv).to have_content order1.reward.description
    expect(csv).to have_content order2.reward.description
    expect(csv).to have_content order1.created_at
    expect(csv).to have_content order2.created_at
    expect(csv).to have_content order1.updated_at
    expect(csv).to have_content order2.updated_at
    expect(csv).to have_content order1.purchase_price
    expect(csv).to have_content order2.purchase_price
    expect(csv).to have_content order1.employee.id
    expect(csv).to have_content order2.employee.id
    expect(csv).to have_content order1.employee.email
    expect(csv).to have_content order2.employee.email
    expect(csv).to have_content order1.employee.full_name
    expect(csv).to have_content order2.employee.full_name
  end
end
