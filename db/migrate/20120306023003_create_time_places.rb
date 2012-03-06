class CreateTimePlaces < ActiveRecord::Migration
  def change
    create_table :time_places do |t|
      t.references :entity
      t.datetime :start
      t.datetime :finish
      t.string :address1
      t.string :address2

      t.timestamps
    end
    add_index :time_places, :entity_id
  end
end
