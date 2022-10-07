class Address < ApplicationRecord
  belongs_to :employee

  validates :street, :postcode, :city, presence: true
end
