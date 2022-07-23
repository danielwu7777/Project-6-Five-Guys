# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class Stock < ApplicationRecord
  has_many :owned_stocks
  has_many :transactions
  after_commit :update_value, on: :update

  # Created 7/23/22 by Jake McCann
  # Fires update on OwnedStock and User when stock value changes
  def update_value
    OwnedStock.update_value ticker, price
    User.update_value
  end

end
