class User < ActiveRecord::Base
  has_secure_password
  has_many :reservations

  validates :username, :email, :password, :password_confirmation, presence: true
end
