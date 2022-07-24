# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class Stock < ApplicationRecord
  has_many :owned_stocks
  has_many :transactions
  #Registers update_value to fire when Stock updated
  after_commit :price_update, on: :update

  # Created 7/23/22 by Jake McCann
  # Fires update on OwnedStock and User when stock value changes
  def price_update
    OwnedStock.price_update ticker, price
  end

end
