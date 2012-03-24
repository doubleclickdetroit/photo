class AddEntityIdToSerializedJson < ActiveRecord::Migration
  def change
    add_column :serialized_jsons, :entity_id, :integer

  end
end
