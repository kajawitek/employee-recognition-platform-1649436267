class RemoveNameAndDescriptionFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :name
    remove_column :employees, :description
  end
end
