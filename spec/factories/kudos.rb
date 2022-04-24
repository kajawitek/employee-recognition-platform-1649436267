FactoryBot.define do
  factory :kudo do
    title { 'factory bot test title' }
    content { 'factory bot test content' }
    giver { create :employee }
    receiver { create :employee }
  end
end
