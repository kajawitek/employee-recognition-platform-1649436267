require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Order spec', type: :feature do
  let!(:reward) { create(:reward, price: 10) }
  let!(:employee) { create(:employee, number_of_available_points: 11) }

  before do
    login_as employee, scope: :employee
    visit rewards_path
  end

  it 'shows a lower number of points after buying a reward' do
    click_link 'Buy'
    expect(page).to have_content 'Order was successfully created'
    expect(page).to have_content 'Your points: 1'
  end
end
