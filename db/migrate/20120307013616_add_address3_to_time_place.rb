class AddAddress3ToTimePlace < ActiveRecord::Migration
  def change
    add_column :time_places, :address3, :string

  end
end
