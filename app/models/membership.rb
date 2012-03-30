class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  def self.for(*args)
    raise ArgumentError, "Expected 2 args, received #{args.size}" if args.size != 2
    
    user,group = [User,Group].map {|klass| args.find {|a| a.instance_of? klass}}
    raise ArgumentError, "Expected an instance of User and Group" unless user && group 

    self.where(:group_id => group.id, :user_id => user.id).first
  end

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role)} > 0"} }

  #ONLY ADD TO THE END OF THIS ARRAY ELSE CHAOS
  ROLES = [:owner, :admin, :associate]
  #ONLY ADD TO THE END OF THIS ARRAY ELSE CHAOS

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def @roles.<<(role)
    @roles << role
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role
  end
end
