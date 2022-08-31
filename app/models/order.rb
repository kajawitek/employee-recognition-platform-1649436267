require 'csv'
class Order < ApplicationRecord
  belongs_to :employee
  belongs_to :reward

  enum delivery_status: { ordered: 'ordered', delivered: 'delivered' }

  def self.to_csv
    orders = all
    CSV.generate do |csv|
      csv << column_names
      orders.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
