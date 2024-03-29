FactoryBot.define do
  factory :order do
    reward
    employee
    purchase_price { rand(1..10) }

    after :create do |order|
      order.deliver! if order.reward.online?
    end
  end
end
