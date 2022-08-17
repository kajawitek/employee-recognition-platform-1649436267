require 'rails_helper'
# frozen_string_literal: true
RSpec.describe 'Reward filter spec', type: :feature do
  let!(:employee) { create(:employee) }
  let!(:category1) { create(:category, title: 'Category 1') }
  let!(:category2) { create(:category, title: 'Category 2') }
  let!(:reward1) { create(:reward, category: category1) }
  let!(:reward2) { create(:reward, category: category2) }

  before do
    login_as employee, scope: :employee
    visit root_path
  end

  it 'tests filtering rewards' do
    click_link 'Rewards'
    click_link category1.title
    expect(page).to have_content reward1.title
    expect(page).not_to have_content reward2.title

    click_link category2.title
    expect(page).not_to have_content reward1.title
    expect(page).to have_content reward2.title

    click_link 'All'
    expect(page).to have_content reward1.title
    expect(page).to have_content reward2.title
  end
end
