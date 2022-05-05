class ChangeCompanyValueTitleToUnique < ActiveRecord::Migration[6.1]
  def change
    add_index :company_values, :title, unique: true
  end
end
