class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address1
      t.string :address2
      t.string :address3
      t.references :entity

      t.timestamps
    end
    add_index :locations, :entity_id
  end
end
