class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :entity
      t.string :line1
      t.string :line2

      t.timestamps
    end
    add_index :locations, :entity_id
  end
end
