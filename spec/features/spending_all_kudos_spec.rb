require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }

  it 'spending all kudos' do
    visit root_path

    fill_in 'employee[email]', with: kudo.giver.email
    fill_in 'employee[password]', with: kudo.giver.password
    click_button 'Log in'

    expect(page).to have_content 'success'

    i = 10
    while i > 0
      click_link 'New Kudo'
      fill_in 'kudo[title]', with: kudo.title
      fill_in 'kudo[content]', with: kudo.content
      select kudo.receiver.email, from: 'kudo[receiver_id]'
      click_button 'Create Kudo'
      expect(page).to have_content 'success'
      i -= 1
    end

    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    click_button 'Create Kudo'

    expect(page).to have_content 'Kudo was not  created. Your number of available kudos is 0'
  end
end
