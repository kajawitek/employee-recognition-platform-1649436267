class AddCategoriesToRewards < ActiveRecord::Migration[6.1]
  def change
    add_reference :rewards, :category, optional: true, foreign_key: true
  end
end

