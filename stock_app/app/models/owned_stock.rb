# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class OwnedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  validates :shares_owned, numericality: {greater_than_or_equal_to: 0, message: "Cannot sell more than owned shares"}

  attr_accessor :total_cost, :shares_owned

  # Created 7/23/22 by Jake McCann
  # Edited 7/25/22 by Jake MCCann
  #
  # Updates the cost of record of OwnedStock on stock price change
  # new_price: new price of stock
  def update_price new_price
    @total_cost = @shares_owned * new_price - @total_cost
    save
  end
end
