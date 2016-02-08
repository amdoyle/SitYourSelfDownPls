class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  has_many :reviews
  has_many :users, through: :reviews

  validates :comment, :rating, presence: true

  def self.search(search, price)


      joins(:category).where("(restaurants.name LIKE ? OR categories.name LIKE ?) AND restaurants.price_range LIKE ?", "%#{search}%", "%#{search}%", "%#{price}%").joins('LEFT JOIN reviews ON restaurants.id = reviews.restaurant_id')
      .group('restaurants.id').order("AVG(reviews.rating) DESC")

  end

  def available?(party_size, time)
    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour, time.end_of_hour).sum(:number)
    party_size > 0 && party_size <= available_capacity
  end


end
