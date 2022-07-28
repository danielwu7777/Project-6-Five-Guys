class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_stocks
  has_many :transactions
  validates :liquidcash, numericality: {greater_than_or_equal_to: 0, message: "Error: not enough funds"}

  # Created 7/25/2022 by Jake McCann
  #
  # Updates users portfolio value
  # old_price: price before update
  # new_price: price after update
  def update_portfolio_value old_price, new_price
    self.currentbalance += new_price - old_price
    self.save
  end
end
