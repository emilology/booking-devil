class AddNumberToTable < ActiveRecord::Migration
  def change
    add_column :tables, :number, :integer
  end
end
