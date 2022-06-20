FactoryBot.define do
  factory :company_value do
    sequence(:title) { |n| "factory bot company value title #{n}" }
  end
end
