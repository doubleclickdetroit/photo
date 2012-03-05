class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :entity
      t.text :text

      t.timestamps
    end
    add_index :comments, :entity_id
  end
end
