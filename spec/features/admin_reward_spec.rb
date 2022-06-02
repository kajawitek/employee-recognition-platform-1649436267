require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin employees spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:reward) { build(:reward) }

  it 'CRUD reward' do
    visit admins_root_path

    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'

    click_link 'Rewards'

    expect(page).to have_content 'Title Price'

    click_link 'New Reward'
    fill_in 'reward[title]', with: ''
    fill_in 'reward[content]', with: reward.content
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'

    expect(page).to have_content 'Title is empty. Reward was not saved.'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[content]', with: ''
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'

    expect(page).to have_content 'Content is empty. Reward was not saved.'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[content]', with: reward.content
    fill_in 'reward[price]', with: nil
    click_button 'Create Reward'

    expect(page).to have_content 'Price is empty or less than 1. Reward was not saved.'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[content]', with: reward.content
    fill_in 'reward[price]', with: 0
    click_button 'Create Reward'

    expect(page).to have_content 'Price is empty or less than 1. Reward was not saved.'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[content]', with: reward.content
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'

    expect(page).to have_content 'Reward was successfully created.'

    click_link 'Show'

    expect(page).to have_content 'Title:'

    click_link 'Back'

    expect(page).to have_content 'Rewards Title	Price	'

    click_link 'Edit'

    fill_in 'reward[title]', with: ''
    click_button 'Update Reward'

    expect(page).to have_content 'Reward was not updated.'

    fill_in 'reward[content]', with: ''
    click_button 'Update Reward'

    expect(page).to have_content 'Reward was not updated.'

    fill_in 'reward[price]', with: nil
    click_button 'Update Reward'

    expect(page).to have_content 'Reward was not updated.'

    fill_in 'reward[price]', with: 0.99
    click_button 'Update Reward'

    expect(page).to have_content 'Reward was not updated.'

    fill_in 'reward[title]', with: 'changed_title'
    fill_in 'reward[content]', with: 'changed_content'
    fill_in 'reward[price]', with: 1.05
    click_button 'Update Reward'

    expect(page).to have_content 'changed_title'
    expect(page).to have_content 'Reward was successfully updated.'

    click_link 'Destroy'

    expect(page).not_to have_content 'changed_title'
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
