require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value) }

  it 'title presence' do
    company_value.title = nil
    expect(company_value).not_to be_valid
  end

  context 'when title is not unique' do
    before do
      same_title = company_value.dup
      same_title.save
    end

    it { is_expected.not_to be_valid }
  end
end
