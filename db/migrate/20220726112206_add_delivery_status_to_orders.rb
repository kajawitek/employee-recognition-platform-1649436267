class AddDeliveryStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_status, :string, default: "ordered"
  end
end
