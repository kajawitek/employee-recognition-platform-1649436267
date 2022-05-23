class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'Employee'
  belongs_to :receiver, class_name: 'Employee'
  belongs_to :company_value, class_name: 'CompanyValue'

  validates :title, :content, presence: true
end
