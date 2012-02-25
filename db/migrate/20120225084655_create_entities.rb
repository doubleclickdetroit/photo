class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :title
      t.string :text
      t.string :type

      t.timestamps
    end
  end
end
