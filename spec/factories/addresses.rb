FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    postcode { '11-111' }
    city { Faker::Address.city }
    employee
  end
end
