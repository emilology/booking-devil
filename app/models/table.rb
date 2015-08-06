class Table < ActiveRecord::Base
belongs_to :combination, class: Table
has_many :seating_arrangements
has_many :bookings, through: :seating_arrangements


def booked_out? date
  ##fetch bookings for the date
  ##check if timeslot available
  ##1.get how much time I need for people
  ##2. get free intervals I have for date
  ##3.see if any intervals could fit time we need for group size
  ##4. return this
  ##4. put number of guests who can use that table when it's free in table "booked out"
end


  # def combinable?
  #  returns true if it exists as a combination and its other table is free
  # end
  #
  # def divisible?
  #
  # end
end
