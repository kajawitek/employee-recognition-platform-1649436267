FactoryBot.define do
  factory :online_code do
    code { SecureRandom.hex(12) }
    reward

    after :create do |online_code|
      online_code.reward.update(number_of_available_items: online_code.reward.number_of_available_items + 1)
    end
  end
end
