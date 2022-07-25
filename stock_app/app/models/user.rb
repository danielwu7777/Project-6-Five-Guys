# Edited 7/23/22 by Jake McCann

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_stocks
  has_many :transactions

  # Created 7/25/2022 by Jake McCann
  # Updates the value of users account when stock price changes
  # old_price: num_stock_owned * pre_update_stock_price
  # new_price: num_stock_owned * post_update_stock_price
  def update_value
  end
end
