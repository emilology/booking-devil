class PageController < ApplicationController
  def tables
    @booking = Booking.new
  end

  # def
  #  @booking = Booking.create
  # end
end


#
# # booking.create, add details from booker / user
#
#   def booking
#   Booking.create(phone_number)
#
#   end
# end
