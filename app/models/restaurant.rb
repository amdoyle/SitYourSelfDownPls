class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  validate :available?

  def available?(party_size, time)
    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour, time.end_of_hour).sum(:number)
    party_size > 0 && party_size <= available_capacity
  end

end
