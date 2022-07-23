class AddCurrentToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :currentbalance, :float
  end
end
