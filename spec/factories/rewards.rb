FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "factory bot reward title #{n}" }
    description { 'Reward - description' }
    price { 9.99 }
  end
end
