class BookingsController < ApplicationController
  @@timeslots = [2.hours, 2.hours, 150.minutes, 150.minutes, 3.hours, 210.minutes, 210.minutes, 210.minutes, 250.minutes, 250.minutes]
  @@booking_times = (17..21).to_a

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

  def available_times
    params.require(:date)
    booking_date = Date.parse(params[:date])

    # delaying until we add the 6people/slot restriction
    # existing_bookings = Booking.where(date: booking_date.beginning_of_day..booking_date.end_of_day)

    guests = 3 # will come from the route, somewhere, based on @booking.number_of_visitors
    tables = Table.where("seats >= ?", guests).sort_by &:seats

    min_table_size = tables.first.seats
    tables = tables.select {|t| t.seats == min_table_size}

    # check availability for tables
    ## how much time do we need?
    needed_time = @@timeslots[guests-1]
    ## which possible start times do I have?
    ## which table has that amount of time available?

    render json: {times:['7:30', '8:00', '8:30', '9:00'], date: booking_date, tables: tables, needed_time: needed_time}
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
