class AddStockIdToOwnedStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :owned_stocks, :stock_id, :integer
  end
end
