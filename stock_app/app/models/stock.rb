# Edited 7/20/22 by Noah Moon
class Stock < ApplicationRecord
  has_many :owned_stocks
  has_many :transactions
end
