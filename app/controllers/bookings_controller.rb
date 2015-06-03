class PageController < ApplicationController
  def tables
    @booking = Booking.new
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(params[:booking])
    if @booking.save
      flash[:booking_id] = @booking.id
      redirect_to "www.hillsidekitchen.co.nz"
    else
      render :action => "new"
    end
  end
  def show
  @booking = Booking.find(params[:id])
  redirect_to @booking.url
  end


end
