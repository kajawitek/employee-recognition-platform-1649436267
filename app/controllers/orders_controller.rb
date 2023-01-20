class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index
    @orders = OrdersQuery.new(employee: current_employee, params: params).call
  end

  def new
    @order = Order.new(reward: Reward.find(params[:reward]))
    @address = Address.find_or_initialize_by(employee: current_employee)
    return render :new unless current_employee.number_of_available_points < @order.reward.price

    redirect_to rewards_path, notice: 'Your number of available points is less than price'
  end

  def create
    @order = Order.new
    @reward = Reward.find(order_params[:reward])
    @address = Address.find_or_initialize_by(employee: current_employee)
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
          @address.update!(address_params) if @reward.post?
          @order.deliver! if @reward.online?
          @reward.online_codes.available.first.update(employee: current_employee, order: @order) if @reward.online?
          @reward.number_of_available_items -= 1 if @reward.online?
          @reward.save!
          EmployeeMailer.reward_delivery_confirmation_email(@order).deliver
        end
        redirect_to orders_url, notice: 'Order was successfully created.'
      rescue ActiveRecord::RecordInvalid => e
        render :new, notice: e.message, reward: @reward
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:reward)
  end

  def address_params
    params.require(:address).permit(:street, :postcode, :city)
  end
end
