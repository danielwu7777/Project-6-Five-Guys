class AddStockToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :stock_id, :integer
  end
end
