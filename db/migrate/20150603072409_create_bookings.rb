class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :dietary_preferences
      t.string :phone_number
      t.integer :number_of_visitors
      t.datetime :time

      t.timestamps null: false
    end
  end
end
