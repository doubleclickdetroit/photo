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

class Task < Entity
  has_one :deadline, :foreign_key => :entity_id

  delegate :due, :due=, :to => :deadline
  delegate :complete, :complete=, :to => :deadline
end

class Event < Entity
  has_one :location, :foreign_key => :entity_id

  delegate :line1, :line2, :line1=, :line2=, :to => :location, :prefix => true
  # alias :attendees :followers
  # alias :attendees= :followers=
end
