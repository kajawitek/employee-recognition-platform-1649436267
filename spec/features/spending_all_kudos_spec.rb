require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { create(:kudo) }

  before do
    login_as kudo.giver, scope: :employee
    visit root_path
  end

  it 'spending all kudos by employee' do
    # spending all avaiable kudos by employee
    while kudo.giver.number_of_available_kudos > 0
      click_link 'New Kudo'
      fill_in 'kudo[title]', with: kudo.title
      fill_in 'kudo[content]', with: kudo.content
      select kudo.receiver.email, from: 'kudo[receiver_id]'
      click_button 'Create Kudo'
      expect(page).to have_content 'success'
      kudo.giver.reload
    end

    # creating new kudo without avaiable kudos by employee
    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was not  created. Your number of available kudos is 0'
  end
end
