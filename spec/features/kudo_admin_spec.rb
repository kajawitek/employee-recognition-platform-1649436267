require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { create(:kudo) }
  let!(:admin) { create(:admin) }

  it 'listing and delete' do

    visit admins_root_path

    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'

    click_link 'Kudos'
    click_link 'Destroy'

    expect(page).to have_content 'Kudo was successfully destroyed.'


  end
end
