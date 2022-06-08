require 'rails_helper'

RSpec.describe Reward, type: :model do
  let!(:reward) { create(:reward) }

  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
end
