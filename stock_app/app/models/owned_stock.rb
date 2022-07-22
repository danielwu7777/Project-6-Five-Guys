# Edited 7/20/22 by Noah Moon
class OwnedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user
end
