# Created 7/22/22 by Noah Moon
class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock
end
