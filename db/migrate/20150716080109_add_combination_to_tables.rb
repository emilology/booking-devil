class AddCombinationToTables < ActiveRecord::Migration
  def change
    add_column :tables, :combination_id, :integer
  end
end
