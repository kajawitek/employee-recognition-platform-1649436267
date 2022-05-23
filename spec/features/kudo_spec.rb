require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }

  it 'crud kudo' do
    visit root_path

    click_link 'Sign Up'

    fill_in 'employee[email]', with: kudo.giver.email
    fill_in 'employee[password]', with: kudo.giver.password
    fill_in 'employee[password_confirmation]', with: kudo.giver.password
    click_button 'Sign up'

    expect(page).to have_content 'success'

    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    select kudo.company_value.title, from: 'kudo[company_value_id]'
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
