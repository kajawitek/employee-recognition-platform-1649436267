class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :postcode
      t.string :city
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
