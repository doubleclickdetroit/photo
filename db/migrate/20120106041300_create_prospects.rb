class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :first
      t.string :last
      t.string :state
      t.string :email
      t.string :heard_from

      t.timestamps
    end
  end
end
