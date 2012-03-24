class CreateSerializedJsons < ActiveRecord::Migration
  def change
    create_table :serialized_jsons do |t|
      t.text :data

      t.timestamps
    end
  end
end
