class ChangeRewardsTitleToUnique < ActiveRecord::Migration[6.1]
  def change
    add_index :rewards, :title, unique: true
  end
end
