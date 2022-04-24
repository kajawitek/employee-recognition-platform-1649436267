FactoryBot.define do
  factory :employee do
    sequence :email do |n|
      "test#{n}@test.com"
    end
    password { 'test123' }
  end
end
