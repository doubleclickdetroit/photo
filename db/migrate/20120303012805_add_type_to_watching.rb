class AddTypeToWatching < ActiveRecord::Migration
  def change
    add_column :watchings, :type, :string
  end
end
