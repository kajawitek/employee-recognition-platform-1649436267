FactoryBot.define do
  factory :kudo do
    sequence(:title) { |n| "factory bot test title #{n}" }
    sequence(:content) { |n| "factory bot test content #{n}" }
    giver { build :employee }
    receiver { create :employee }
    company_value { create :company_value }
  end
end
