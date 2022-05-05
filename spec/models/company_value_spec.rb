require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  let!(:company_value) { create(:company_value)}

  it 'title presence' do
    company_value.title = nil
    expect(company_value).not_to be_valid
  end

  context 'title uniqueness validations' do
    before do
      same_title = company_value.dup
      same_title.save
    end

    it { should_not be_valid }
  end
end
