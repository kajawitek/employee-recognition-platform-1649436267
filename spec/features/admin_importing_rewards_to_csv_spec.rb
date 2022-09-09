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

    # admin imports correct file
    attach_file(file_fixture('import_rewards_test.csv'))
    click_button 'Import'
    expect(page).to have_content 'Rewards imported!'
    expect(Reward.count).to eq 3
  end
end
