class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward

  has_one :online_code, dependent: :destroy

  enum delivery_status: { ordered: 'ordered', ready_for_pick_up: 'ready for pick-up', delivered: 'delivered' }
end
