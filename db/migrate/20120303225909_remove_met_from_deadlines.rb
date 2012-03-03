class RemoveMetFromDeadlines < ActiveRecord::Migration
  def up
    remove_column :deadlines, :met
  end

  def down
    add_column :deadlines, :met, :boolean
  end
end
