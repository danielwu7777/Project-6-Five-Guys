class AddPurchasesToOwnedStock < ActiveRecord::Migration[6.1]
  def change
    add_column :owned_stocks, :purchased, :integer
  end
end
