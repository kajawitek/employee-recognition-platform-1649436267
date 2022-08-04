require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin adding kudos to employee', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:employee1) { create(:employee, number_of_available_kudos: 10) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 10) }

  let!(:company_value) { create(:company_value) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'tests adding kudos to employees' do
    # checking adding 0 kudos
    click_link 'Add Kudos'
    fill_in 'number_of_additional_kudos', with: '0'
    click_button 'Add kudos'
    expect(page).to have_content 'Additional kudos must be between 1 and 20'
    expect(page).to have_content employee1.number_of_available_kudos = 10
    expect(page).to have_content employee2.number_of_available_kudos = 10

    # checking adding 22 kudos
    click_link 'Add Kudos'
    fill_in 'number_of_additional_kudos', with: '22'
    click_button 'Add kudos'
    expect(page).to have_content 'Additional kudos must be between 1 and 20'
    expect(page).to have_content employee1.number_of_available_kudos = 10
    expect(page).to have_content employee2.number_of_available_kudos = 10

    # checking adding 10 kudos
    click_link 'Add Kudos'
    fill_in 'number_of_additional_kudos', with: '10'
    click_button 'Add kudos'
    expect(page).to have_content 'Additional kudos added'
    expect(page).to have_content employee1.number_of_available_kudos = 20
    expect(page).to have_content employee2.number_of_available_kudos = 20
  end
end
