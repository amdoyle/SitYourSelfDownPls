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

  def available?(party_size, time, reservation_updating=nil)
    party_size = party_size.to_i
    time = time.to_time

    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour-5.hours, time.end_of_hour-5.hours).sum(:number)
    if reservation_updating
      if reservation_updating.time == time.beginning_of_hour-5.hours && reservation_updating.time < time.end_of_hour-5.hours
        available_capacity += reservation_updating.number
      end
    end
    
    party_size > 0 && party_size <= available_capacity

  end

  def convert_time(time)

    case time
    when 0
      "12:00 AM"
    when 1
      "1:00 AM"
    when 2
      "2:00 AM"
    when 3
      "3:00 AM"
    when 4
      "4:00 AM"
    when 5
      "5:00 AM"
    when 6
      "6:00 AM"
    when 7
      "7:00 AM"
    when 8
      "8:00 AM"
    when 9
      "9:00 AM"
    when 10
      "10:00 AM"
    when 11
      "11:00 AM"
    when 12
      "12:00 PM"
    when 13
      "1:00 PM"
    when 14
      "2:00 PM"
    when 15
      "3:00 PM"
    when 16
      "4:00 PM"
    when 17
      "5:00 PM"
    when 18
      "6:00 PM"
    when 19
      "7:00 PM"
    when 20
      "8:00 PM"
    when 21
      "9:00 PM"
    when 22
      "10:00 PM"
    when 23
      "11:00 PM"
    else
      "Invalid time"
    end

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
