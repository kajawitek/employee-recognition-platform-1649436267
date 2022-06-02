class Reward < ApplicationRecord
  validates :price, numericality: { greater_or_equal_than: 1 }
  validates :title, :content, :price, presence: true
end
