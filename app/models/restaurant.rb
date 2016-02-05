class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner

  def self.search(search)
    joins(:category).where("restaurants.name LIKE ? or categories.name LIKE ?", "%#{search}%","%#{search}%")
  end

end
