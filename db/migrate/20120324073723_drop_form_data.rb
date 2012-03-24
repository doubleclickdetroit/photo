class DropFormData < ActiveRecord::Migration
  def up
    drop_table :form_data
  end

  def down
    # frowntown
  end
end
