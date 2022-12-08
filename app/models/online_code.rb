class OnlineCode < ApplicationRecord
  belongs_to :reward
  belongs_to :employee, optional: true
  belongs_to :order, optional: true

  validates :code, uniqueness: true

  scope :available, -> { where(employee_id: nil) }
end
