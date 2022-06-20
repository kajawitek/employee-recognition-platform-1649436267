require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { create(:kudo) }
  let!(:admin) { create(:admin) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'RD kudos by admin' do
    # listing kudos by admin
    click_link 'Kudos'
    expect(page).to have_content kudo.title
    expect(page).to have_content kudo.content
    expect(page).to have_content kudo.giver.email
    expect(page).to have_content kudo.receiver.email

    # destroying kudos by admin
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
