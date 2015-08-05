class AddEndTimeToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :endtime, :datetime
  end
end
