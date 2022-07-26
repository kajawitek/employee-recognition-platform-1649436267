module Admins
  class OrdersController < AdminsController
    def index
      @orders = Order.order(delivery_status: :desc)
    end

    def update
      @order = Order.find(params[:id])
      if @order.delivered?
        redirect_to admins_orders_url, notice: 'You can\'t deliver this order again.'
      else
        @order.update(delivery_status: :delivered)
        redirect_to admins_orders_url, notice: 'Order was successfully delivered.'
      end
    end
  end
end
