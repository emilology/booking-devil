module BookingsHelper
  def build_booking(booking)
    booking.categories.build if booking.categories.empty?
    booking
  end
end
