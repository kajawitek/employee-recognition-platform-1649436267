FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "factory bot reward title #{n}" }
    sequence(:description) { |m| "Reward - description #{m}" }
    price { rand(1..10) }
    category { create :category }
    delivery_method { Reward.delivery_methods.values.sample }
    number_of_available_items { 0 }

    trait :post do
      delivery_method { :post }
    end

    trait :online do
      delivery_method { :online }
    end
  end
end
