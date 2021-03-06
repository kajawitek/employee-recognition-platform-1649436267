class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrdersQuery.new(employee: current_employee, params: params).call
  end

  def create
    @order = Order.new
    @reward = Reward.find(params[:reward])
    if current_employee.number_of_available_points < @reward.price
      redirect_to rewards_path, notice: 'Order was not created. Your number of available points is less than price'
    else
      @order.employee = current_employee
      @order.reward = @reward
      @order.employee.number_of_available_points -= @reward.price
      @order.purchase_price = @order.reward.price
      begin
        ActiveRecord::Base.transaction do
          current_employee.save!
          @order.save!
        end
        redirect_to orders_url, notice: 'Order was successfully created.'
      rescue ActiveRecord::RecordInvalid => e
        render :new, notice: e.message, reward: @reward
      end
    end
  end
end
