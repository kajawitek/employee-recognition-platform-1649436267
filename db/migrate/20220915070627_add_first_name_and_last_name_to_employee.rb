class AddFirstNameAndLastNameToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :first_name, :string, null: false, default: ""
    add_column :employees, :last_name, :string, null: false, default: ""
  end
end


