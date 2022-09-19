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

    if kudo.giver.full_name.present?
      expect(page).to have_content kudo.giver.full_name
    else
      expect(page).to have_content kudo.giver.email
    end

    if kudo.receiver.full_name.present?
      expect(page).to have_content kudo.receiver.full_name
    else
      expect(page).to have_content kudo.receiver.email
    end

    # destroying kudos by admin
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
