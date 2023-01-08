require 'rails_helper'

RSpec.describe 'Reward pagination spec', type: :feature do
  let!(:reward1) { create(:reward, :post, number_of_available_items: 3) }
  let!(:reward2) { create(:reward, :post, number_of_available_items: 3) }
  let!(:reward3) { create(:reward, :post, number_of_available_items: 3) }
  let!(:reward4) { create(:reward, :post, number_of_available_items: 3) }
  let!(:employee) { create(:employee) }

  before do
    login_as employee, scope: :employee
    visit root_path
  end

  it 'checks moving between pages of the rewards list' do
    click_link 'Rewards'
    expect(page).to have_content reward1.title
    expect(page).to have_content reward2.title
    expect(page).to have_content reward3.title
    expect(page).not_to have_content reward4.title
    expect(page).not_to have_link('First')
    expect(page).not_to have_link('Prev')
    expect(page).to have_link('Next')
    expect(page).to have_link('Last')

    click_link '2'
    expect(page).not_to have_content reward1.title
    expect(page).not_to have_content reward2.title
    expect(page).not_to have_content reward3.title
    expect(page).to have_content reward4.title
    expect(page).to have_link('First')
    expect(page).to have_link('Prev')
    expect(page).not_to have_link('Next')
    expect(page).not_to have_link('Last')
    expect(page).not_to have_link('3')

    click_link 'First'
    expect(page).to have_content reward1.title
    expect(page).to have_content reward2.title
    expect(page).to have_content reward3.title
    expect(page).not_to have_content reward4.title
    expect(page).not_to have_link('First')
    expect(page).not_to have_link('Prev')
    expect(page).to have_link('Next')
    expect(page).to have_link('Last')

    click_link 'Next'
    expect(page).not_to have_content reward1.title
    expect(page).not_to have_content reward2.title
    expect(page).not_to have_content reward3.title
    expect(page).to have_content reward4.title
    expect(page).to have_link('First')
    expect(page).to have_link('Prev')
    expect(page).not_to have_link('Next')
    expect(page).not_to have_link('Last')
    expect(page).not_to have_link('3')

    click_link 'Prev'
    expect(page).to have_content reward1.title
    expect(page).to have_content reward2.title
    expect(page).to have_content reward3.title
    expect(page).not_to have_content reward4.title
    expect(page).not_to have_link('First')
    expect(page).not_to have_link('Prev')
    expect(page).to have_link('Next')
    expect(page).to have_link('Last')

    click_link 'Last'
    expect(page).not_to have_content reward1.title
    expect(page).not_to have_content reward2.title
    expect(page).not_to have_content reward3.title
    expect(page).to have_content reward4.title
    expect(page).to have_link('First')
    expect(page).to have_link('Prev')
    expect(page).not_to have_link('Next')
    expect(page).not_to have_link('Last')
    expect(page).not_to have_link('3')
  end
end
