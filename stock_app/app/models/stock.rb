# Edited 7/20/22 by Noah Moon
# Edited 7/23/22 by Jake McCann
class Stock < ApplicationRecord
  has_many :owned_stocks
  has_many :transactions

  attr_accessor :price

  # Created 7/23/22 by Jake McCann
  # Edited 7/24/22 by Jake McCann
  #
  # Updates stock price
  def update_price new_price
    @price = new_price
    save
  end

end
