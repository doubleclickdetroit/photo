class AddRolesMaskToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :roles_mask, :integer
  end
end
