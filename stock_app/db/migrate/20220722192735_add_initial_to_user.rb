class AddInitialToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :initialbalance, :float
  end
end
