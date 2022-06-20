require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Employee spec', type: :feature do
  let!(:employee) { build(:employee) }

  it 'signs up and logs in by employees' do
    # signing up by employees
    visit root_path
    click_link 'Sign Up'
    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    fill_in 'employee[password_confirmation]', with: employee.password
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully.'

    # logging in by employees
    click_link 'Sign Out'
    fill_in 'employee[email]', with: employee.email
    fill_in 'employee[password]', with: employee.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
