# Preview all emails at http://localhost:3000/rails/mailers/employee
class EmployeePreview < ActionMailer::Preview
  def reward_delivery_confirmation_email(order: FactoryBot.build(:order))
    EmployeeMailer.reward_delivery_confirmation_email(order)
  end
end
