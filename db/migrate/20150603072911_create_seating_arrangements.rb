class CreateSeatingArrangements < ActiveRecord::Migration
  def change
    create_table :seating_arrangements do |t|
      t.integer :booking_id
      t.integer :table_id

      t.timestamps null: false
    end
  end
end
