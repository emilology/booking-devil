class PageController < ApplicationController
  def booking
    @booking = Booking.new
  end

  def booking.create
    if @booking = Booking.create(params[:booking])
      # success
    else
      # error handling
    end
  end

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
  end
end
  #
  # def create
  #   @booking = Booking.new(params[:booking])
  #   if @booking.save
  #     flash[:booking_id] = @booking.id
  #     redirect_to "www.hillsidekitchen.co.nz"
  #   else
  #     render :action => "new"
  #   end
  # end
  # def show
  # @booking = Booking.find(params[:id])
  # redirect_to @booking.url
  # end
