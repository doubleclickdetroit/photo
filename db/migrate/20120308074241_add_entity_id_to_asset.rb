class AddEntityIdToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :entity_id, :integer

  end
end
