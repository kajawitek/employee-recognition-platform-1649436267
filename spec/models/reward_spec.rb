require 'rails_helper'

RSpec.describe Reward, type: :model do
  let!(:reward) { create(:reward) }

  it 'is valid with valid attributes' do
    expect(reward).to be_valid
  end

  context 'when title is empty' do
    before do
      reward.title = nil
    end

    it { is_expected.not_to be_valid }
  end

  context 'when content is empty' do
    before do
      reward.content = nil
    end

    it { is_expected.not_to be_valid }
  end

  context 'when price is empty' do
    before do
      reward.price = nil
    end

    it { is_expected.not_to be_valid }
  end

  context 'when price less than' do
    before do
      reward.price == 0
    end

    it { is_expected.not_to be_valid }
  end
end
