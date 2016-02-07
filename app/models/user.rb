class User < ActiveRecord::Base
  has_secure_password
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :categories, through: :restaurants
  has_many :reviews
  has_many :restaurants, through: :reviews

  validates :password, :password_confirmation, presence: true
  validates :username, :email, presence: true, uniqueness: true

end
