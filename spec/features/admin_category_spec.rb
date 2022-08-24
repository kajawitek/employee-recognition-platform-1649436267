require 'rails_helper'
RSpec.describe 'Admin category spec', type: :feature do
  let!(:admin) { create(:admin) }
  let!(:category) { build(:category) }
  let!(:reward) { create(:reward, category: nil) }

  before do
    login_as admin, scope: :admin
    visit admins_root_path
  end

  it 'tests the creation of a category, adding it to the reward and removing it by admin' do
    # creation of a category by admin
    click_link 'Categories'
    click_link 'New Category'
    click_button 'Create Category'
    expect(page).to have_content "Title can't be blank"
    fill_in 'category[title]', with: category.title
    click_button 'Create Category'
    expect(page).to have_content 'Category was successfully created.'

    # adding category to the reward by admin
    click_link 'Rewards'
    expect(page).to have_content 'no category'
    click_link 'Edit'
    select category.title, from: 'reward[category_id]'
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated.'
    expect(page).to have_content category.title

    # removing category from the reward by admin
    click_link 'Edit'
    select 'None', from: 'reward[category_id]'
    click_button 'Update Reward'
    expect(page).to have_content 'Reward was successfully updated'
    expect(page).to have_content 'no category'
  end
end
