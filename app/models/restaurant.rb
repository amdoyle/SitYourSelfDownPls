class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  has_many :reviews
  has_many :users, through: :reviews

  def self.search(search)
    joins(:category).where("restaurants.name LIKE ? or categories.name LIKE ?", "%#{search}%","%#{search}%").joins('LEFT JOIN reviews ON restaurants.id = reviews.restaurant_id')
    .group('restaurants.id').order("AVG(reviews.rating) DESC")
  end

  def available?(party_size, time)
    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour, time.end_of_hour).sum(:number)
    party_size > 0 && party_size <= available_capacity
  end

  def authorize
    if current_owner
      @restaurant = Restaurant.find(params[:id])
        if !@restaurant.owner_id == current_owner.id
          flash[:notice] = "You can't edit this content."
        end
    elsif current_user
    else
    end
  end
end
