class RemoveDietaryPreferenceFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :dietary_preference, :string
  end
end
