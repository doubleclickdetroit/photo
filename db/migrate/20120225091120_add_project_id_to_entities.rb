class AddProjectIdToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :project_id, :integer
  end
end
