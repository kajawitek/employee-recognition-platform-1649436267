FactoryBot.define do
  factory :reward do
    sequence(:title) { |n| "factory bot reward title #{n}" }
    content { 'Reward - content' }
    price { 9.99 }
  end
end
