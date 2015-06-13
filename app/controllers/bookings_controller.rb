class BookingsController < ApplicationController
before_action :load_product, only: [:show, :update, :edit, :destroy]
before_action :load_wizard, only: [:booking, :edit, :create, :update]

  def booking
    @booking = @wizard.object
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
    @booking = @wizard.object
    if @wizard.save
      redirect_to @booking, notice: "Thank you #{@booking.name}, your booking has been created! See you then. You may cancel with 48 hours notice."
    else
      render :new
    end
  end

  def update
    if @wizard.save
      redirect_to @booking, notice: "Booking was successfully updated."
    else
      render action: 'edit'
    end
  end

private

  def load_product
    @booking = Booking.find(params[:id])
  end
  def load_wizard
    @wizard = ModelWizard.new(@booking || Booking, session, params)
    if self.action.name.in? %w[booking edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
  end
end
