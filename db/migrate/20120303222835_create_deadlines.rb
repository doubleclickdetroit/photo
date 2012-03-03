class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.references :entity
      t.datetime :due
      t.boolean :met

      t.timestamps
    end
    add_index :deadlines, :entity_id
  end
end
