class Ability
  include CanCan::Ability

  def if_user_has_roles(user, roles)
    Proc.new do |instance|
      group = instance.instance_of?(Group) ? instance : instance.group
      instance && user.has_role?(roles, :for => group)
    end
  end
  alias :if_user_has_role :if_user_has_roles

  def if_user_is_a_member(user)
    Proc.new do |instance|
      instance && user.belongs_to?(instance.group)
    end
  end

  def if_user_owns_instance(user)
    Proc.new do |instance|
      instance && instance.user == user 
    end
  end

  def initialize(user)
    user ||= User.new

    # Comments
    can [:read,:create], Comment, &if_user_is_a_member(user)
    can [:update,:destroy], Comment, &if_user_owns_instance(user)

    # Watchings
    can [:create,:destroy], Watching, &if_user_is_a_member(user)


    # OWNER
    can :manage, Group, &if_user_has_roles(user, :owner)

    # ADMIN
    can [:read, :update], Group, &if_user_has_role(user, :admin)

    # OWNER / ADMIN
    can :manage, Project, &if_user_has_roles(user, [:owner,:admin]) 
    can :manage, Phase, &if_user_has_roles(user, [:owner,:admin]) 
    can :manage, Entity, &if_user_has_roles(user, [:owner,:admin])
    can :create, Invitation, &if_user_has_roles(user, [:owner,:admin]) 
    # can :destroy, Comment, &if_user_has_roles(user, [:owner,:admin])

    # ASSOCIATE
    can :read, Group, &if_user_has_role(user, :associate)
    can :read, Project, &if_user_has_role(user, :associate)
    can :read, Phase, &if_user_has_role(user, :associate)
    can [:read, :create, :update], Entity, &if_user_has_role(user, :associate)
  end
end
