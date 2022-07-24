class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :owned_stocks
  has_many :transactions
  validates :liquidcash, numericality: {greater_than_or_equal_to: 0, message: "Error: not enough funds"}
end
