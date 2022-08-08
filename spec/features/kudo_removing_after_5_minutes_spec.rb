require 'rails_helper'

RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { create(:kudo) }

  before do
    login_as kudo.giver, scope: :employee
    visit root_path
  end

  it 'checks if employee can remove kudo 5 minutes after it was sent' do
    travel 6.minutes do
      click_link 'Destroy'
      expect(page).to have_content "You don't have access to this kudo"
    end
  end
end
