class AddAssignableTypeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :assignable_type, :string
  end
end
