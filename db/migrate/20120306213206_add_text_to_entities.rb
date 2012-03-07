class AddTextToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :text, :text

  end
end
