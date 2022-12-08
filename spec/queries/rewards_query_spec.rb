require 'rails_helper'

describe RewardsQuery do
  before do
    Bullet.enable = false
  end

  context 'with empty params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      reward1 = create(:reward, :post, category: category1, number_of_available_items: 3)
      create(:reward, :post, category: category2, number_of_available_items: 0)
      create(:reward, :online, category: category1, number_of_available_items: 0)
      reward4 = create(:reward, :online, category: category2, number_of_available_items: 3)
      filter = {}

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward1, reward4])
    end
  end

  context 'with Category1 params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      reward1 = create(:reward, :post, category: category1, number_of_available_items: 3)
      create(:reward, :post, category: category2, number_of_available_items: 0)
      create(:reward, :online, category: category1, number_of_available_items: 0)
      create(:reward, :online, category: category2, number_of_available_items: 3)
      filter = { 'category' => category1.title }

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward1])
    end
  end

  context 'with Category2 params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      create(:reward, :post, category: category1, number_of_available_items: 3)
      create(:reward, :post, category: category2, number_of_available_items: 0)
      create(:reward, :online, category: category1, number_of_available_items: 0)
      reward4 = create(:reward, :online, category: category2, number_of_available_items: 3)
      filter = { 'category' => category2.title }

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward4])
    end
  end
end
