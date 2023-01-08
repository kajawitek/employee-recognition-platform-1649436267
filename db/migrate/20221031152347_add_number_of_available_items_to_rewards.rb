class AddNumberOfAvailableItemsToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :number_of_available_items, :integer, default: 0
  end
end
