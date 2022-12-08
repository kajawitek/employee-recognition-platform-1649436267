require 'rails_helper'
RSpec.describe 'Admin importing rewards spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:category1) { create(:category, title: 'Category 1') }
  let!(:category2) { create(:category, title: 'Category 2') }
  let!(:category3) { create(:category, title: 'Category 3') }
  let!(:category4) { create(:category, title: 'Category 4') }
  let!(:reward) { create(:reward, title: 'Reward 1', description: 'Description 1', price: 1, category: category1) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'tests admin importing rewards from csv' do
    expect(Reward.count).to eq 1
    click_link 'Rewards'
    click_link 'Import Rewards'

    # admin imports xlsx file
    attach_file(file_fixture('import_rewards_test.xlsx'))
    click_button 'Import'
    expect(page).to have_content 'Please choose CSV file'
    expect(Reward.count).to eq 1

    # admin imports file with duplicates
    attach_file(file_fixture('import_rewards_test_with_duplicates.csv'))
    click_button 'Import'
    expect(page).to have_content 'Your file have duplicated rewards titles'
    expect(Reward.count).to eq 1

    # admin imports file with empty title
    attach_file(file_fixture('import_rewards_test_empty_title.csv'))
    click_button 'Import'
    expect(page).to have_content "Validation failed: Title can't be blank"
    expect(Reward.count).to eq 1

    # admin imports file with category that doesn't exist
    attach_file(file_fixture('import_rewards_test_category_doesnt_exist.csv'))
    click_button 'Import'
    expect(page).to have_content "Category: Category 5 doesn't exist"
    expect(Reward.count).to eq 1

    # admin imports file with delivery_method that doesn't exist
    attach_file(file_fixture('import_rewards_test_delivery_method_doesnt_exist.csv'))
    click_button 'Import'
    expect(page).to have_content "Delivery method: online1 doesn't exist"
    expect(Reward.count).to eq 1

    # admin imports file with wrong numb of avaiable items
    attach_file(file_fixture('import_rewards_test_with_wrong_numb_of_items.csv'))
    click_button 'Import'
    expect(page).to have_content 'Number of items: 1 should be 0'
    expect(Reward.count).to eq 1

    # admin imports correct file
    attach_file(file_fixture('import_rewards_test.csv'))
    click_button 'Import'
    expect(page).to have_content 'Rewards imported!'
    expect(Reward.count).to eq 3

    expect(Reward.find_by(title: 'Reward 1').description).to eq 'Description 1 updated'
    expect(Reward.find_by(title: 'Reward 1').price).to eq 4
    expect(Reward.find_by(title: 'Reward 1').category.title).to eq 'Category 4'

    expect(Reward.find_by(title: 'Reward 2').description).to eq 'Description 2'
    expect(Reward.find_by(title: 'Reward 2').price).to eq 2
    expect(Reward.find_by(title: 'Reward 2').category.title).to eq 'Category 2'

    expect(Reward.find_by(title: 'Reward 3').description).to eq 'Description 3'
    expect(Reward.find_by(title: 'Reward 3').price).to eq 3
    expect(Reward.find_by(title: 'Reward 3').category.title).to eq 'Category 3'
  end
end
