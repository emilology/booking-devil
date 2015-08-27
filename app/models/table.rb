class Table < ActiveRecord::Base
  belongs_to :combination, class: Table
  has_many :seating_arrangements
  has_many :bookings, through: :seating_arrangements

  def busytimes
    #### get all busy times of bookings
    busytimes = []
    self.bookings.each do |booking|
      time = booking.time
      endtime = booking.endtime
      #work out busy times for each day
      start_timeslot = getTimeslot(time)
      end_timeslot = getTimeslot(endtime)
      #turn this into an array of busy times between start & end time (inclusive)
      busytimes + ((start_timeslot..end_timeslot).step(30.minutes).to_a)
    end
    #### check, for each start time, if its interval (start time -- start time + needed_time) overlaps any existing booking
  end
  # def combinable?
  #  returns true if it exists as a combination and its other table is free
  # end
  #
  # def divisible?
  # end

  private
  def getTimeslot (time)
    time.hour.hours+time.min.minutes
  end
end
