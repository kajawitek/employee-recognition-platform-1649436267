require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin employees spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'list employees' do
    click_link 'Employees'

    expect(page).to have_content 'Employees Email Number of kudos'

    click_link 'Edit'

    expect(page).to have_content 'Editing Employee'

    fill_in 'employee[email]', with: 'edited@test.pl'
    fill_in 'employee[password]', with: 'Passwordedited'

    click_button 'Update Employee'

    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content 'edited@test.pl'

    visit root_path

    fill_in 'employee[email]', with: 'edited@test.pl'
    fill_in 'employee[password]', with: 'Passwordedited'

    click_button 'Log in'

    expect(page).to have_content 'success'

    visit admins_root_path

    click_link 'Employees'

    expect(page).to have_content 'Employees Email Number of kudos'

    click_link 'Edit'

    expect(page).to have_content 'Editing Employee'

    fill_in 'employee[email]', with: 'edited2@test.pl'

    click_button 'Update Employee'

    expect(page).to have_content 'Employee was successfully updated.'
    expect(page).to have_content 'edited2@test.pl'

    visit root_path
    click_link 'Sign Out'

    fill_in 'employee[email]', with: 'edited2@test.pl'
    fill_in 'employee[password]', with: 'Passwordedited'

    click_button 'Log in'

    expect(page).to have_content 'success'
    click_link 'Sign Out'

    visit admins_root_path

    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'

    click_link 'Employees'

    expect(page).to have_content 'Employees Email Number of kudos'

    click_link 'Destroy'

    expect(page).to have_content 'Employee was successfully destroyed.'
  end
end
