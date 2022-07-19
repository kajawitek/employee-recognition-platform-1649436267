FactoryBot.define do
  factory :order do
    reward
    employee
    purchase_price { 10 }
  end
end
