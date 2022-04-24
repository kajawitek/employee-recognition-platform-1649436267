FactoryBot.define do
  factory :kudo do
    sequence(:title) { |n| "factory bot test title #{n}" }
    sequence(:content) { |n| "factory bot test content #{n}" }
    giver { create :employee }
    receiver { create :employee }
  end
end
