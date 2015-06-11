class WelcomeController < ApplicationController
  def index
  render layout: "booking_layout"
  @booking = Booking.all
  end

  def index
    @bookings = Booking.all
  end



  # def puts "Booking.all"
  # end
end
