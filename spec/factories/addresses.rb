FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    postcode { Faker::Address.zip_code }
    city { Faker::Address.city }
    employee
  end
end
