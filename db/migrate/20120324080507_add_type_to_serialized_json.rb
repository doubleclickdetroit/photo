class AddTypeToSerializedJson < ActiveRecord::Migration
  def change
    add_column :serialized_jsons, :type, :string

  end
end
