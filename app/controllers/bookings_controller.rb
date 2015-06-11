class BookingsController < ApplicationController

  @booking = Booking.new

  def create
    @booking = Booking.new
  end

  def update
      @booking = Booking.new
  end
  def index
    @bookings = Booking.all
  end
  def show
    @booking = Booking.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:email, :name, :phone_number, :number_of_visitors, :time)
  end

  def list
    @booking = Booking.order("id ASC")
  end
end
