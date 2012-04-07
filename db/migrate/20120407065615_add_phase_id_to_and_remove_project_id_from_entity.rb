class AddPhaseIdToAndRemoveProjectIdFromEntity < ActiveRecord::Migration
  def change
    remove_column :entities, :project_id, :integer

    add_column :entities, :phase_id, :integer

  end
end
