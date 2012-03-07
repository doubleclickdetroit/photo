class RemoveTextFromEntities < ActiveRecord::Migration
  def up
    remove_column :entities, :text
      end

  def down
    add_column :entities, :text, :string
  end
end
