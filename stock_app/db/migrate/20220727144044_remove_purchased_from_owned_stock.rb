class RemovePurchasedFromOwnedStock < ActiveRecord::Migration[6.1]
  def change
    remove_column :owned_stocks, :purchased, :integer
  end
end
