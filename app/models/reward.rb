class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :reward_photo, blob: { content_type: ['image/png', 'image/jpg'] }
  validates :number_of_available_items, presence: true, if: :post?
  validates :number_of_available_items, numericality: { greater_than_or_equal_to: 0 }, if: :online?

  has_many :orders, dependent: :destroy
  has_many :online_codes, dependent: :destroy
  belongs_to :category, optional: true
  has_one_attached :reward_photo

  paginates_per 3

  enum delivery_method: { online: 'online', post: 'post', pick_up: 'pick-up' }

  scope :available, -> { where('number_of_available_items > 0') }
end
