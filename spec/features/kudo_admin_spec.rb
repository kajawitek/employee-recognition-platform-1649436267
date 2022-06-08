require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { create(:kudo) }
  let!(:admin) { create(:admin) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'listing and delete' do
    click_link 'Kudos'
    click_link 'Destroy'

    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
