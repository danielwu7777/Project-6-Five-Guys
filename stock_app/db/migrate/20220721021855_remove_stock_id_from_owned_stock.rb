class RemoveStockIdFromOwnedStock < ActiveRecord::Migration[6.1]
  def change
    remove_column :owned_stocks, :stock_id, :string
  end
end
