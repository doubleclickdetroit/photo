class AddAssignableIdToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :assignable_id, :integer
  end
end
