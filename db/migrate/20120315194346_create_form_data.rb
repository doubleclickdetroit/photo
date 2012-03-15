class CreateFormData < ActiveRecord::Migration
  def change
    create_table :form_data do |t|
      t.integer :entity_id
      t.text :data

      t.timestamps
    end
  end
end
