class AddEntityTypeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :entity_type, :string
  end
end
