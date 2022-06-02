class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :rewards, :desctiption, :content
  end
end
