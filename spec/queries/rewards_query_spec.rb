require 'rails_helper'

describe RewardsQuery do
  before do
    Bullet.enable = false
  end

  context 'with empty params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      reward1 = create(:reward, category: category1)
      reward2 = create(:reward, category: category2)
      filter = {}

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward1, reward2])
    end
  end

  context 'with Category1 params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      reward1 = create(:reward, category: category1)
      create(:reward, category: category2)
      filter = { 'category' => category1.title }

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward1])
    end
  end

  context 'with Category2 params' do
    it 'filter' do
      category1 = create(:category, title: 'Category 1')
      category2 = create(:category, title: 'Category 2')
      create(:reward, category: category1)
      reward2 = create(:reward, category: category2)
      filter = { 'category' => category2.title }

      expect(RewardsQuery.new(filters: filter).call).to match_array([reward2])
    end
  end
end
