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

    ## which possible start times do I have? -> @@booking_times

    ## which table has that amount of time available starting at those times?
    ## -->
    ### for each table
    #### get bookings
    #### check, for each start time, if its interval (start time -- start time + needed_time) overlaps any existing booking
    #### if it doesn't, save it for returning it
    available_times = []
    #### available_times.push(start_time)

    ## for each booking add end time dependent on needed_time
    ## look into partial / SQL view for database to see if you can make new table saying "tables free this night for 2s / 4s / 6s if this process is too slow."

    render json: {times:available_times, date: booking_date, tables: tables, needed_time: needed_time}


    # in your datepicker, if you choose the jquery-ui one at least, you'll have a function that will run
    # before enabling a day. In that function you'll have to call this endpoint to figure out if you have availability for
    # the day and the amount of guests and, based on this response, choose to grey out the day or not.
    # Remember to grey out sundays and mondays every time.
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
