class EmployeeMailer < ApplicationMailer
  def reward_delivery_confirmation_email(order)
    @employee = order.employee
    @order = order

    mail(to: @employee.email, subject: 'Your reward was delivered')
  end
end
