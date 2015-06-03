class PageController < ApplicationController
  def tables
    @booking = Booking.new
  end

  def
   @booking = Booking.create

  end

@booking.save
  # end
end
