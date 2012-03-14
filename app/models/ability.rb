class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # OWNER / ADMIN
    can :manage, Group do |group|
      group && user.has_role?([:owner,:admin], :for => group)
    end
    can :manage, Project do |project|
      project && user.has_role?([:owner,:admin], :for => project.group)
    end
    can :manage, Entity do |entity|
      entity && user.has_role?([:owner,:admin], :for => entity.group)
    end

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

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
