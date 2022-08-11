class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true

  has_many :orders, dependent: :destroy

  paginates_per 3
end
