# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class OwnedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  # Created 7/23/22 by Jake McCann
  # Updates the cost of record of OwnedStock and fires user value update when stock price updates
  # ticker: stock symbol for stock whose price was updated
  # new_price: new price of stock
  def self.price_update ticker, new_price
    where(:ticker => ticker).each do |record|
      old_price = record.total_cost
      record.total_cost = record.shares_owned * new_price
      User.price_update record.user_id, old_price, record.total_cost
      record.save
    end
  end
end
