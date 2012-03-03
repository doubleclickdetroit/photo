class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :entity_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
