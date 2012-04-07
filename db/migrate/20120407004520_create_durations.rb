class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.datetime :start
      t.datetime :finish
      t.references :entity

      t.timestamps
    end
    add_index :durations, :entity_id
  end
end
