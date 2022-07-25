class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_stocks
  has_many :transactions
  validates :liquidcash, numericality: {greater_than_or_equal_to: 0, message: "Error: not enough funds"}

  # Created 7/23/2022 by Jake McCann
  # Updates the value of users account when stock price updates
  # old_price: num_stock_owned * pre_update_stock_price
  # new_price: num_stock_owned * post_update_stock_price
  # user_id: id of user whole value is being updated
  def self.price_update user_id, old_price, new_price
    user = User.where(:id => user_id).first
    user.currentbalance += (new_price - old_price)
    user.save
  end
end
