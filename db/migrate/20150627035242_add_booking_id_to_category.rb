class AddBookingIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :booking_id, :integer
    add_index :categories, :booking_id
  end
end
