class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  validate :available?

  def available?(party_size, time)
    party_size = party_size.to_i
    time = time.to_time
    puts "TIME: #{time}"

    available_capacity = capacity - reservations.where('time >= ? and time < ?', time.beginning_of_hour-5.hours, time.end_of_hour-5.hours).sum(:number)
    puts "AVAILABLE: #{available_capacity}"
    party_size > 0 && party_size <= available_capacity

  end

end
