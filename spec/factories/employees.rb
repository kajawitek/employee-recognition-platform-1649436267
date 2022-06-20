FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "test#{n}@test.com" }
    password { 'test123' }
    number_of_available_kudos { 10 }
    number_of_available_points { 0 }
  end
end
