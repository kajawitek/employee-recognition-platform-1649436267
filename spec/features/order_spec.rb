require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order spec', type: :feature do
  let!(:reward) { create(:reward) }
  let!(:employee) { create(:employee, number_of_available_points: 11) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'shows a lower number of points after buying a reward' do
    click_link 'Buy'
    click_button 'Create Order'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 1'
  end
end
