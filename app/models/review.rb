class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  validates :comment, :rating, presence: true, uniqueness: true
end
