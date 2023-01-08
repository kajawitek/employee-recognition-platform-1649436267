require 'rails_helper'
RSpec.describe 'Admin importing rewards spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:reward1) { create(:reward, title: 'Reward 1', delivery_method: 'online') }
  let!(:reward2) { create(:reward, title: 'Reward 2', delivery_method: 'post') }
  let!(:reward3) { create(:reward, title: 'Reward 3', delivery_method: 'online') }
  let!(:reward4) { create(:reward, title: 'Reward 4', delivery_method: 'online') }

  let!(:category1) { create(:category, title: 'Category 1') }
  let!(:category2) { create(:category, title: 'Category 2') }
  let!(:category3) { create(:category, title: 'Category 3') }
  let!(:category4) { create(:category, title: 'Category 4') }
  let!(:reward) { create(:reward, title: 'Reward', description: 'Description 1', price: 1, category: category1) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it "can't import without file" do
    click_link 'Online codes'
    click_button 'Import'
    expect(page).to have_content 'Please add file'
  end

  it "doesn't import xlsx file" do
    click_link 'Online codes'
    attach_file(file_fixture('import_online_codes_test.xlsx'))
    click_button 'Import'
    expect(page).to have_content 'Please choose CSV file'
  end

  it "doesn't import file when reward doesn't exist" do
    click_link 'Online codes'
    attach_file(file_fixture('import_online_codes_test_reward_doesnt_exist.csv'))
    click_button 'Import'
    expect(page).to have_content "Reward: Reward - doesn't exist doesn't exist"
    expect(OnlineCode.count).to eq 0
  end

  it "doesn't import file when there is reward with post delivery method" do
    click_link 'Online codes'
    attach_file(file_fixture('import_online_codes_test_post_reward.csv'))
    click_button 'Import'
    expect(page).to have_content "Reward: Reward 2 have post delivery method. You can't create online code for it"
    expect(OnlineCode.count).to eq 0
  end

  it 'imports correct file' do
    click_link 'Online codes'
    attach_file(file_fixture('import_online_codes_test.csv'))
    click_button 'Import'
    expect(page).to have_content 'Online codes imported!'
    expect(OnlineCode.count).to eq 3
  end
end
