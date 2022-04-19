class AddDetailsToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :name, :string
    add_column :employees, :description, :text
  end
end
