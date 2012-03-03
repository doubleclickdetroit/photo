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
  delegate :group, :to => :project

  has_many :watchings
  has_many :followers, :through => :watchings, :source => :user 

  has_one :assignment
  has_one :assignee, :through => :assignment, :source => :user 

  def unassign!
    assignment.destroy && reload
  end
end
