class Owner < ActiveRecord::Base
  has_many :restaurants
  has_secure_password
end
