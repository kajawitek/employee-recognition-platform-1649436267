class CreateKudos < ActiveRecord::Migration[6.1]
  def change
    create_table :kudos do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :giver, null: false, foreign_key: {to_table: :employees}
      t.references :receiver, null: false, foreign_key: {to_table: :employees}

      t.timestamps
    end
  end
end
