class BookingsController < ApplicationController
  @@timeslots = [2.hours, 2.hours, 150.minutes, 150.minutes, 3.hours, 210.minutes, 210.minutes, 210.minutes, 250.minutes, 250.minutes]
  @@slot_times = (17.hours..21.hours)
  @@booking_times = (@@slot_times.step(30.minutes).each {|t| puts t})
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

    ##ask table of busy times which times are free for that number of visitors for all times & dates

    ### output these dates

    #### run times for that date
    available_table_times=[]
    ## which table has that amount of time available starting at those times?
    ## -->
    ### for each table
    tables.each do |table|
      #### get bookings
      #### check, for each start time, if its interval (start time -- start time + needed_time) overlaps any existing booking
      busy = table.busytimes
      #### if it doesn't, save it for returning it
      #### available_times.push(start_time)
      free = @@booking_times.to_a-busy
      #####define all available timeslots with period of time free
      needed_intervals = (needed_time/30.minutes)
      available_table_times + (findFreeWithNeededTime(free, needed_intervals))
      ## for each booking add end time dependent on needed_time

      ## look into partial / SQL view for database to see if you can make new table saying "tables free this night for 2s / 4s / 6s if this process is too slow."
    end
    render json: {times:available_table_times, date: booking_date, tables: tables, needed_time: needed_time}

    # in your datepicker, if you choose the jquery-ui one at least, you'll have a function that will run
    # before enabling a day. In that function you'll have to call this endpoint to figure out if you have availability for
    # the day and the amount of guests and, based on this response, choose to grey out the day or not.
    # Remember to grey out sundays and mondays every time.
  end

  def findFreeWithNeededTime (free, needed_intervals)

    #build consecutive time arrays
    consecutive_intervals = consecutiveTimeslots(free)

    ##reject those arrays that are shorter than needed_intervals
    # consecutive_intervals.select! {|interval| interval.length > needed_intervals}
    ###take amount of needed timeslots minus 1 from end of each accepted array
    free_intervals = []
    consecutive_intervals.each {|i| free_intervals + (i[0..-needed_intervals])}
    ##### merge all arrays and return time

    #free = @@booking_times.reject(busy)
    #needed_time = @@timeslots[guests-1]
    free_intervals
  end

  def consecutiveTimeslots (free)
    #first array variable - set up initial variables
    consecutive_intervals = []
    previous = free.first
    temp_array = []
    temp_array << free.first

    free[1..-1].each do |time|
      if time-previous != 30.minutes
        consecutive_intervals << temp_array
        temp_array = []
      end

      temp_array << time
      previous = time
    end
    consecutive_intervals
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
