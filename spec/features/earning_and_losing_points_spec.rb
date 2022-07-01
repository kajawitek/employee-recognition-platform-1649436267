require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }
  let!(:company_value) { create(:company_value) }

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
    kudo.receiver.reload

    # checking available points for receiver
    using_session('receiver session') do
      login_as kudo.receiver, scope: :employee
      visit root_path
      expect(page).to have_content 'Your points: 1'
    end

    # destroying given kudo as giver
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
    kudo.receiver.reload

    # checking available points for receiver after destroying kudo by giver
    using_session('receiver session') do
      login_as kudo.receiver, scope: :employee
      visit root_path
      expect(page).to have_content 'Your points: 0'
    end
  end
end
