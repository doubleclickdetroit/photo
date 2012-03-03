class RemoveEntityIdFromAssignment < ActiveRecord::Migration
  def up
    remove_column :assignments, :entity_id
  end

  def down
    add_column :assignments, :entity_id, :integer
  end
end
