#initialized 7/20/22 by Noah Moon
# Edited 7/20/22 by Noah Moon added relation
class Stock < ApplicationRecord
  has_many :owned_stocks
end
