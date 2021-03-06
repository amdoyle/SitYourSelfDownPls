class Owner < ActiveRecord::Base
  validates :username, :email, :presence => true, :uniqueness => true
  has_many :restaurants
  has_many :reservations, through: :restaurants
  has_secure_password
end
