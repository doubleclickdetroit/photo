class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.integer :user_id
      t.integer :entity_id
      t.boolean :assigned

      t.timestamps
    end
  end
end
