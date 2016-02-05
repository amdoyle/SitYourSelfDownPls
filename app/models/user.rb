class User < ActiveRecord::Base
  has_secure_password
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :categories, through: :restaurants

  validates :username, :email, :password, :password_confirmation, presence: true
end
