class Order < ApplicationRecord
  include AASM

  belongs_to :employee
  belongs_to :reward

  has_one :online_code, dependent: :destroy

  aasm :delivery_status do
    state :ordered, initial: true
    state :delivered
    state :ready_for_pick_up

    event :deliver do
      transitions from: %i[ordered ready_for_pick_up], to: :delivered
    end

    event :prepare_to_pick_up do
      transitions from: :ordered, to: :ready_for_pick_up
    end
  end
end
