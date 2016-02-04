class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner

  def self.search(search)
    where("name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end

end
