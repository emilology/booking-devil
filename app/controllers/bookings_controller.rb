class BookingsController < ApplicationController

  def booking
    @booking = Booking.new
  end

  def list
  @bookings = Booking.order("id ASC")
  end

  def show
  @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:email, :name, :phone_number, :number_of_visitors, :time)
  end

  def create
    if @booking = Booking.create!(booking_params)
      # success
    else
      # error handling
    end
    redirect_to :action => :list
  end
end
