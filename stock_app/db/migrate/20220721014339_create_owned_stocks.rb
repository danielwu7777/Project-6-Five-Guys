class CreateOwnedStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :owned_stocks do |t|
      t.integer :user_id
      t.string :ticker
      t.integer :shares_owned
      t.float :total_cost

      t.timestamps
    end
  end
end
