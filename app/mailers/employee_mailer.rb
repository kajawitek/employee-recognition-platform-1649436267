class EmployeeMailer < ApplicationMailer
  def reward_delivery_confirmation_email(order)
    @employee = order.employee
    @order = order

    mail(to: @employee.email, subject: 'Your reward was delivered')
  end

  def reward_pick_up_instruction_email(order)
    @employee = order.employee
    @order = order

    mail(to: @employee.email, subject: 'Your reward is ready for pick-up')
  end
end
