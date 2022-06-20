require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }
  let!(:company_value) {create(:company_value)}

  before do
    login_as kudo.giver, scope: :employee
    visit root_path
  end

  it 'gives point for earned kudos and reduces for lost kudo' do
    # creating new kudo for receiver
    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    select company_value.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
    kudo.giver.reload

   # signing in as receiver and checking available points
    click_link 'Sign Out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    fill_in 'employee[email]', with: kudo.receiver.email
    fill_in 'employee[password]', with: kudo.receiver.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Your points: 1'

    # signing in as giver and destroing given kudo
    click_link 'Sign Out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    fill_in 'employee[email]', with: kudo.giver.email
    fill_in 'employee[password]', with: kudo.giver.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Your points: 0'
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'

   # signing in as receiver and checking available points
   click_link 'Sign Out'
   expect(page).to have_content 'You need to sign in or sign up before continuing.'
   fill_in 'employee[email]', with: kudo.receiver.email
   fill_in 'employee[password]', with: kudo.receiver.password
   click_button 'Log in'
   expect(page).to have_content 'Signed in successfully'
   expect(page).to have_content 'Your points: 0'
  end
end
