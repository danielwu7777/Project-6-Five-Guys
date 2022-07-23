# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class OwnedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  # Created 7/23/22 by Jake McCann
  # Updates the cost of record of OwnedStock when stock price updates
  # ticker: stock symbol for stock whose price was updated
  # new_price: new price of stock
  def self.update_value ticker, new_price
    where(:ticker => ticker).each do |record|
      record.total_cost = record.shares_owned * new_price
      record.save
    end
  end
end
