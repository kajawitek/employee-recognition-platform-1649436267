require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Kudo spec', type: :feature do
  let!(:kudo) { build(:kudo) }
  let!(:kudo2) { build(:kudo) }
  let!(:company_value) { create(:company_value) }

  before do
    login_as kudo.giver, scope: :employee
    visit root_path
  end

  it 'CRUD kudos by employees' do
    # creating and listing kudos by employees
    click_link 'New Kudo'
    fill_in 'kudo[title]', with: kudo.title
    fill_in 'kudo[content]', with: kudo.content
    select kudo.receiver.email, from: 'kudo[receiver_id]'
    select company_value.title, from: 'kudo[company_value_id]'
    click_button 'Create Kudo'
    expect(page).to have_content 'Kudo was successfully created.'
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

    expect(page).to have_content company_value.title

    # editing and listing kudos by employees
    click_link 'Edit'
    fill_in 'kudo[title]', with: "#{kudo.title} edited"
    fill_in 'kudo[content]', with: "#{kudo.content} edited"
    click_button 'Update Kudo'
    expect(page).to have_content 'Kudo was successfully updated.'
    expect(page).to have_content "#{kudo.title} edited"
    expect(page).to have_content "#{kudo.content} edited"
    expect(page).to have_content kudo.giver.email
    expect(page).to have_content kudo.receiver.email
    expect(page).to have_content company_value.title

    # destroying kudos by employees
    click_link 'Back'
    click_link 'Destroy'
    expect(page).to have_content 'Kudo was successfully destroyed.'
  end
end
