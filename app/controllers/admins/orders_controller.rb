require 'csv'

module Admins
  class OrdersController < AdminsController
    def index
      @orders = Order.includes(:reward, :employee).order(delivery_status: :desc)
      respond_to do |format|
        format.html
        format.csv { render template: 'admins/orders/orders' }
      end
    end

    def deliver
      @order = Order.find(params[:id])
      if @order.delivered?
        redirect_to admins_orders_url, notice: "You can't deliver this order again."
      elsif @order.update(delivery_status: :delivered)
        @order.reward.update(number_of_available_items: @order.reward.number_of_available_items - 1)
        EmployeeMailer.reward_delivery_confirmation_email(@order).deliver
        redirect_to admins_orders_url, notice: 'Order was successfully delivered.'
      else
        redirect_to admins_orders_url, notice: "Order wasn't delivered"
      end
    end

    def prepare_to_pick_up
      @order = Order.find(params[:id])
      begin
        ActiveRecord::Base.transaction do
          EmployeeMailer.reward_pick_up_instruction_email(@order).deliver
          @order.ready_for_pick_up!
        end
        redirect_to admins_orders_path, notice: 'Pick-up instruction sent!'
      rescue ActiveRecord::RecordInvalid => e
        render :index, notice: e.message, order: @order
      end
    end
  end
end
