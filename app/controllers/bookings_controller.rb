class BookingsController < ApplicationController
  before_action :load_booking, only: [:show, :update, :edit, :destroy]
  before_action :load_wizard, only: [:new, :edit, :create, :update]

  def index
    @booking = Booking.all
  end

    def show
    end

  def new
    @booking = @wizard.object
  end

  def edit
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

  def destroy
    @booking.destroy
    redirect_to bookings_url
  end

private

  def load_booking
    @booking = Booking.find(params[:id])
  end
  def load_wizard
    @wizard = ModelWizard.new(@booking || Booking, session, params)
    if self.action_name.in? %w[new edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
  end
end
