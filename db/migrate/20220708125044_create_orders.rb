class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.decimal :purchase_price, null: false
      
      t.timestamps
    end
  end
end
