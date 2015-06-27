class RemoveProjectIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :project_id, :integer
  end
end
