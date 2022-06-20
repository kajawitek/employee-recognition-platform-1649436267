require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Admin reward spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:reward) { build(:reward) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'CRUD rewards by admin' do
    # creating new rewards without title by admin
    click_link 'Rewards'
    click_link 'New Reward'
    fill_in 'reward[title]', with: nil
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'
    expect(page).to have_content 'Title can\'t be blank'

    # creating new rewards without description by admin
    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: nil
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'
    expect(page).to have_content 'Description can\'t be blank'

    # creating new rewards wihout price by admin
    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: nil
    click_button 'Create Reward'
    expect(page).to have_content 'Price can\'t be blank'

    # creating new rewards with price=0 by admin
    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: 0
    click_button 'Create Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'

    # creating and listing new rewards with title, description and correct price by admin
    fill_in 'reward[title]', with: reward.title
    fill_in 'reward[description]', with: reward.description
    fill_in 'reward[price]', with: reward.price
    click_button 'Create Reward'
    expect(page).to have_content 'Reward was successfully created.'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price

    # showing and listing rewards by admin
    click_link 'Show'
    expect(page).to have_content reward.title
    click_link 'Back'
    expect(page).to have_content reward.title
    expect(page).to have_content reward.price

    # editing rewards with empty title by admin
    click_link 'Edit'
    fill_in 'reward[title]', with: ''
    click_button 'Update Reward'
    expect(page).to have_content 'Title can\'t be blank'

    # editing rewards with empty description by admin
    fill_in 'reward[description]', with: ''
    click_button 'Update Reward'
    expect(page).to have_content 'Description can\'t be blank'

    # editing rewards with empty price by admin
    fill_in 'reward[price]', with: nil
    click_button 'Update Reward'
    expect(page).to have_content 'Price can\'t be blank'

    # editing rewards with price=0.99 by admin
    fill_in 'reward[price]', with: 0.99
    click_button 'Update Reward'
    expect(page).to have_content 'Price must be greater than or equal to 1'

    # editing and listing rewards with title, description and correct price by admin
    fill_in 'reward[title]', with: 'changed_title'
    fill_in 'reward[description]', with: 'changed_description'
    fill_in 'reward[price]', with: 1.05
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).to have_content 'changed_title'
    expect(page).to have_content '1.05'

    # destroying rewards by admin
    click_link 'Destroy'
    expect(page).to have_content 'Reward was successfully destroyed.'
    expect(page).to_not have_content 'changed_title'
    expect(page).to_not have_content '1.05'
  end
end
