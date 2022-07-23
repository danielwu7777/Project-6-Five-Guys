# Edited 7/20/22 by Noah Moon
class OwnedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  validates :shares_owned, numericality: {greater_than_or_equal_to: 0, message: "Cannot sell more than owned shares"}
end
