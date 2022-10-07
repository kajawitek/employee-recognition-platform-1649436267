class Reward < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :reward_photo, blob: { content_type: ['image/png', 'image/jpg'] }

  has_many :orders, dependent: :destroy
  belongs_to :category, optional: true
  has_one_attached :reward_photo

  paginates_per 3

  enum delivery_method: { online: 'online', post: 'post' }
end
