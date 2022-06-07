require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value) }

  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to validate_uniqueness_of(:title) }
end
