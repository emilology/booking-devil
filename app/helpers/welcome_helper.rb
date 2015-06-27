module WelcomeHelper
  def list
    @bookings = Booking.order("id ASC")
  end
end
