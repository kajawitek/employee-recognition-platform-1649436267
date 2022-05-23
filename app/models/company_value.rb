class CompanyValue < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :kudos, class_name: 'Kudo', dependent: :destroy
end
