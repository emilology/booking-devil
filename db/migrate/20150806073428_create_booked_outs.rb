class CreateBookedOuts < ActiveRecord::Migration
  def change
    create_table :booked_outs do |t|
      t.references :table
      t.date :day

      t.timestamps null: false
    end
  end
end
