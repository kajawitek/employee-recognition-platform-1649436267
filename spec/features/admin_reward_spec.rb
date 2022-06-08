require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin reward spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:reward) { build(:reward) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'CRUD reward' do
    click_link 'Rewards'

    expect(page).to have_content 'Title Price'

    click_link 'New Reward'
    fill_in 'reward[title]', with: ''
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'

    expect(page).to have_content 'Title can\'t be blank'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: ''
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'

    expect(page).to have_content 'Description can\'t be blank'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: nil
    click_button 'Create Reward'

    expect(page).to have_content 'Price can\'t be blank'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: 0
    click_button 'Create Reward'

    expect(page).to have_content 'Price must be greater than or equal to 1'

    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
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

    expect(page).to have_content 'Title can\'t be blank'

    fill_in 'reward[description]', with: ''
    click_button 'Update Reward'

    expect(page).to have_content 'Description can\'t be blank'

    fill_in 'reward[price]', with: nil
    click_button 'Update Reward'

    expect(page).to have_content 'Price can\'t be blank'

    fill_in 'reward[price]', with: 0.99
    click_button 'Update Reward'

    expect(page).to have_content 'Price must be greater than or equal to 1'

    fill_in 'reward[title]', with: 'changed_title'
    fill_in 'reward[description]', with: 'changed_description'
    fill_in 'reward[price]', with: 1.05
    click_button 'Update Reward'

    expect(page).to have_content 'changed_title'
    expect(page).to have_content 'Reward was successfully updated.'

    click_link 'Destroy'

    expect(page).not_to have_content 'changed_title'
    expect(page).to have_content 'Reward was successfully destroyed.'
  end
end
