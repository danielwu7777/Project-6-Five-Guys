#initialized 7/20/22 by Noah Moon
# Edited 7/20/22 by Noah Moon added relation
class OwnedStock < ApplicationRecord
  belongs_to :stock
end
