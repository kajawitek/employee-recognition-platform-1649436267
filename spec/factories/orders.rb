FactoryBot.define do
  factory :order do
    reward
    employee
    purchase_price { rand(1..10) }
  end
end
