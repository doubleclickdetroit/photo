class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Comments
    can [:read,:create], Comment do |comment|
      comment && user.belongs_to?(comment.entity.project.group)
    end
    can [:update,:destroy], Comment do |comment|
      comment && user == comment.user
    end

    # Watchings
    can [:create,:destroy], Watching do |watching|
      watching && user.belongs_to(watching.entity.project.group)
    end


    # OWNER
    can :manage, Group do |group|
      group && user.has_role?(:owner, :for => group)
    end

    # ADMIN
    can [:read, :update], Group do |group|
      group && user.has_role?(:admin, :for => group)
    end

    # OWNER / ADMIN
    can :manage, Project do |project|
      project && user.has_role?([:owner,:admin], :for => project.group)
    end
    can :manage, Entity do |entity|
      entity && user.has_role?([:owner,:admin], :for => entity.group)
    end
    can :create, Invitation do |invitation|
      invitation && user.has_role?([:owner,:admin], :for => invitation.group)
    end
    # can :destroy, Comment do |comment|
    #   comment && user.has_role?([:owner,:admin], :for => comment.project.group)
    # end

    # ASSOCIATE
    can :read, Group do |group|
      group && user.has_role?(:associate, :for => group)
    end
    can :read, Project do |project|
      project && user.has_role?(:associate, :for => project.group)
    end
    can [:read, :create, :update], Entity do |entity|
      entity && user.has_role?(:associate, :for => entity.group)
    end
  end
end
