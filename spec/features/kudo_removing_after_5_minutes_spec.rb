require 'rails_helper'

RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo1) { create(:kudo) }
  let!(:kudo2) { create(:kudo, giver: kudo1.giver) }

  before do
    login_as kudo1.giver, scope: :employee
    visit root_path
  end

  it 'checks if employee can remove kudo 5 minutes after it was sent and delete kudo before 5 minutes time period pass' do
    travel 4.minutes do
      find('tr', text: kudo1.title).click_link('Destroy')
      expect(page).to have_content 'Kudo was successfully destroyed.'
    end
    travel 6.minutes do
      find('tr', text: kudo2.title).click_link('Destroy')
      expect(page).to have_content 'You are not authorized to perform this action.'
    end
  end
end
