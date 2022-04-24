FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "test#{n}@test.com" }
    password { 'test123' }
  end
end
