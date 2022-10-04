FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { "#{first_name}.#{last_name}@test.com" }
    password { 'test123' }
    number_of_available_kudos { 10 }
    number_of_available_points { 0 }
  end
end
