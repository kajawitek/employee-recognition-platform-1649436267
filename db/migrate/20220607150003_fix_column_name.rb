class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :rewards, :content, :description
  end
end
