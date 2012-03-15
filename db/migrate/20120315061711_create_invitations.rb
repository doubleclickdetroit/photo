class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :first
      t.string :last
      t.string :email
      t.integer :group_id
      t.integer :inviter_id
      t.text :message

      t.timestamps
    end
  end
end
