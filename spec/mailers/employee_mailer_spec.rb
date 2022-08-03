require 'rails_helper'

RSpec.describe EmployeeMailer, type: :mailer do
  let(:order) { create(:order) }
  let(:mail) { described_class.reward_delivery_confirmation_email(order) }

  it { expect(mail.subject).to eql('Your reward was delivered') }
  it { expect(mail.to).to eql([order.employee.email]) }
  it { expect(mail.from).to eql(['employeerp.kw@gmail.com']) }
  it { expect(mail.body.encoded).to match(order.reward.title) }
end
