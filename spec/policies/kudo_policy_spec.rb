require 'rails_helper'

describe KudoPolicy do
  subject(:kudo_policy) { described_class }

  let(:employee1) { create(:employee) }
  let(:employee2) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee1) }

  permissions :edit?, :update?, :destroy? do
    it 'grants access if employee is a giver' do
      expect(kudo_policy).to permit(employee1, kudo)
    end

    it 'denies access if employee is not a giver' do
      expect(kudo_policy).not_to permit(employee2, kudo)
    end

    it 'denies access if kudo created more than 5 minutes ago' do
      travel 6.minutes do
        expect(kudo_policy).not_to permit(employee1, kudo)
      end
    end

    it 'grants access if kudo created less than 5 minutes ago' do
      travel 4.minutes do
        expect(kudo_policy).to permit(employee1, kudo)
      end
    end
  end
end
