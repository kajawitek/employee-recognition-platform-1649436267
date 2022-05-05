FactoryBot.define do
  factory :company_value do
    sequence(:title) { |n| "factory bot test title #{n}" }
  end
end
