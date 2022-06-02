class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :title, null: false
      t.text :desctiption, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
