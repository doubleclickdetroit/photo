class AddUserAccessorsToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :created_by_id, :integer

    add_column :entities, :updated_by_id, :integer

  end
end
