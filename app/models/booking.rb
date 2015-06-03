class Booking < ActiveRecord::Base
  has_many :seating_arrangements
  has_many :tables, through: :seating_arrangements

  def index
      @booking = Booking.all
  end
end
