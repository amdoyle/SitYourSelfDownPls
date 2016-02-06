class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  has_many :reviews
  has_many :users, through: :reviews

  def self.search(search)
    joins(:category).where("restaurants.name LIKE ? or categories.name LIKE ?", "%#{search}%","%#{search}%")
  end

  def available?(party_size, time)
    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour, time.end_of_hour).sum(:number)
    party_size > 0 && party_size <= available_capacity
  end

end
