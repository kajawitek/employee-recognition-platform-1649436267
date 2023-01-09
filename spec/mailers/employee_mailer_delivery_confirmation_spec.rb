require 'rails_helper'

RSpec.describe EmployeeMailer, type: :mailer do
  let(:order) { create(:order, reward: create(:reward, :online), online_code: create(:online_code)) }
  let(:delivery_confirmation_mail) { described_class.reward_delivery_confirmation_email(order) }

  it { expect(delivery_confirmation_mail.subject).to eql('Your reward was delivered') }
  it { expect(delivery_confirmation_mail.to).to eql([order.employee.email]) }
  it { expect(delivery_confirmation_mail.from).to eql(['employeerp.kw@gmail.com']) }
  it { expect(delivery_confirmation_mail.body.encoded).to match(order.reward.title) }
  it { expect(delivery_confirmation_mail.body.encoded).to match(order.online_code.code) }
end
