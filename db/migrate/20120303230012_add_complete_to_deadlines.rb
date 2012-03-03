class AddCompleteToDeadlines < ActiveRecord::Migration
  def change
    add_column :deadlines, :complete, :boolean, :default => false, :null => false
  end
end
