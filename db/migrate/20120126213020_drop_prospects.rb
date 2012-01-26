class DropProspects < ActiveRecord::Migration
  def up
    drop_table :prospects
  end

  def down
    # no turning back
  end
end
