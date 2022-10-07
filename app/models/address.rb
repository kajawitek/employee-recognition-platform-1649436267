class Address < ApplicationRecord
  belongs_to :employee

  validates :street, :postcode, :city, presence: true
  validates :postcode, format: { with: /[0-9]{2}-[0-9]{3}/, message: 'should be in the form 12-345' }
end
