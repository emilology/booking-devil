class AddDietaryPreferenceToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :dietary_preference, :string
  end
end
