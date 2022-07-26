class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward

  enum delivery_status: { ordered: 'ordered', delivered: 'delivered' }
end
