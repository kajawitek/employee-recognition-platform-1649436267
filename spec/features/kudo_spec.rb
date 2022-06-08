require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }
  let!(:company_value) { create(:company_value) }

  before do
    login_as kudo.giver, scope: :employee
    visit root_path
  end

  it 'crud kudo' do
    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    select company_value.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'

    expect(page).to have_content 'success'

    click_link 'Edit'
    fill_in 'kudo[title]', with: "#{kudo.title} edited"
    click_button 'Update Kudo'
    expect(page).to have_content 'success'

    click_link 'Back'

    click_link 'Destroy'

    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
