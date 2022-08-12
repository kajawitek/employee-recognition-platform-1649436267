class Category < ApplicationRecord
  has_many :rewards, dependent: :destroy

  validates :title, presence: true
end
