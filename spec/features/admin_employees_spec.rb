require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin employees spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'RUD employees by admin' do
    # listing employees by admin
    click_link 'Employees'
    expect(page).to have_content employee.full_name
    expect(page).to have_content employee.email
    expect(page).to have_content employee.number_of_available_kudos

    # editing employees by admin
    click_link 'Edit'
    expect(page).to have_content 'Editing Employee'
    fill_in 'employee[first_name]', with: 'New first name'
    fill_in 'employee[last_name]', with: 'New last name'
    fill_in 'employee[email]', with: 'edited@test.pl'
    fill_in 'employee[password]', with: 'Passwordedited'
    click_button 'Update Employee'
    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content 'New first name'
    expect(page).to have_content 'New last name'
    expect(page).to have_content 'edited@test.pl'
    expect(page).to have_content employee.number_of_available_kudos

    # loging in employees with new email and password
    visit root_path
    fill_in 'employee[email]', with: 'edited@test.pl'
    fill_in 'employee[password]', with: 'Passwordedited'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    # destroying employees by admin
    visit admins_root_path
    click_link 'Employees'
    click_link 'Destroy'
    expect(page).to have_content 'Employee was successfully destroyed.'
    expect(page).not_to have_content employee.email
    expect(page).not_to have_content employee.number_of_available_kudos
    expect(page).not_to have_content employee.full_name
  end
end
