require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin company value spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:company_value) { build(:company_value) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'CRUD company value' do
    click_link 'Company Values'

    expect(page).to have_content 'Company Values Title'

    click_link 'New Company Value'
    fill_in 'company_value[title]', with: ''
    click_button 'Create Company value'

    expect(page).to have_content 'Title can\'t be blank'

    fill_in 'company_value[title]', with: company_value.title
    click_button 'Create Company value'

    expect(page).to have_content 'Company Value was successfully created.'

    click_link 'Show'

    expect(page).to have_content 'Title:'

    click_link 'Back'

    expect(page).to have_content 'Company Values Title'

    click_link 'Edit'

    fill_in 'company_value[title]', with: 'changed_title'
    click_button 'Update Company value'

    expect(page).to have_content 'changed_title'
    expect(page).to have_content 'Company Value was successfully updated.'

    click_link 'Destroy'

    expect(page).not_to have_content 'changed_title'
    expect(page).to have_content 'Company Value was successfully destroyed.'
  end
end
