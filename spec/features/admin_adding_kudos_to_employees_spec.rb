require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin adding kudos to employee', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:employee1) { create(:employee, number_of_available_kudos: 10) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 15) }

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

    # checking adding 22 kudos
    click_link 'Add Kudos'
    fill_in 'number_of_additional_kudos', with: '22'
    click_button 'Add kudos'
    expect(page).to have_content 'Additional kudos must be between 1 and 20'

    # checking adding 10 kudos
    employee1_kudos_number_before = employee1.reload.number_of_available_kudos
    employee2_kudos_number_before = employee2.reload.number_of_available_kudos
    added_kudos = rand(1..20)

    click_link 'Add Kudos'
    fill_in 'number_of_additional_kudos', with: added_kudos
    click_button 'Add kudos'

    tr_employee1 = page.find("tr[employee-id=\"#{employee1.id}\"]")
    tr_employee2 = page.find("tr[employee-id=\"#{employee2.id}\"]")

    expect(page).to have_content 'Additional kudos added'
    expect(tr_employee1).to have_content employee1_kudos_number_before + added_kudos
    expect(tr_employee2).to have_content employee2_kudos_number_before + added_kudos
  end
end
