require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin spec', type: :feature do
  let!(:admin) { create(:admin) }

  it 'log in' do
    visit admins_root_path

    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end
end
