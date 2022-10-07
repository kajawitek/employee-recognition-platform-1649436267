FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "factory bot reward title #{n}" }
    description { 'Reward - description' }
    price { rand(1..10) }
    category { create :category }
    delivery_method { Reward.delivery_methods.values.sample }
  end
end
