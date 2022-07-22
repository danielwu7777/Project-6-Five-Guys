class AddLiquidCashToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :liquidcash, :float
  end
end
