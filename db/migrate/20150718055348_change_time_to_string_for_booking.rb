class ChangeTimeToStringForBooking < ActiveRecord::Migration
  def up
    change_column :bookings, :time, :string
  end

  def down
    change_column :bookings, :time, :datetime
  end
end
