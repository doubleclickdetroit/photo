class Entity < ActiveRecord::Base
  # todo dynamically
  TYPES = [Task]
  TYPES_HASH = Hash[TYPES.map{|i| [i.to_s,i]}]

  def self.spawn(*args, &block)
    entity = args.first
    klass = TYPES_HASH[entity[:type]]
    klass.new args.first
  end

  belongs_to :project
  has_many :watchings
  has_many :followers, :through => :watchings, :source => :user 

  delegate :group, :to => :project

  # todo scope to group?
  def assign_to(user)
    unassign!

    watcher = Watching.find_or_create_by_entity_id_and_user_id self.id, user.id
    watcher.assign!
  end

  def unassign!
    # watchings.each &:unassign! 
    watchings.assignments.each {|a| a.assigned = false; a.save}
  end

  def assignee
    watchings.assignments.limit(1).first.try(:user)
  end
end
