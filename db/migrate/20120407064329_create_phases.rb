class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.references :project

      t.timestamps
    end
    add_index :phases, :project_id
  end
end
