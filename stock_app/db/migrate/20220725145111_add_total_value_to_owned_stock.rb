class AddTotalValueToOwnedStock < ActiveRecord::Migration[6.1]
  def change
    add_column :owned_stocks, :current_value, :float
  end
end
