require 'rails_helper'

RSpec.describe EmployeeMailer, type: :mailer do
  let(:order) { create(:order, reward: create(:reward, :pick_up)) }
  let(:pick_up_instruction_mail) { described_class.reward_pick_up_instruction_email(order) }

  it { expect(pick_up_instruction_mail.subject).to eql('Your reward is ready for pick-up') }
  it { expect(pick_up_instruction_mail.to).to eql([order.employee.email]) }
  it { expect(pick_up_instruction_mail.from).to eql(['employeerp.kw@gmail.com']) }
  it { expect(pick_up_instruction_mail.body.encoded).to match(order.reward.title) }
end
