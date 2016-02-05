class Restaurant < ActiveRecord::Base
  has_many :reservations
  belongs_to :category
  belongs_to :owner
  validate :available?

  def available?(number, time)

    available_capacity = capacity - reservations.where(time).sum(:number)
    number > 0 && number <= available_capacity
  end

end
