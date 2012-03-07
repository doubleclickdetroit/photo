class Entity < ActiveRecord::Base
  # todo dynamically
  TYPES = [Task]
  TYPES_HASH = Hash[TYPES.map{|i| [i.to_s,i]}]

  def self.spawn(*args, &block)
    entity = args.first
    klass = TYPES_HASH[entity[:type]]
    klass.new args.first
  end

  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  belongs_to :project
  delegate :group, :to => :project

  has_many :comments

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
  has_one :time_place, :foreign_key => :entity_id
  delegate :start, :start=, 
           :finish, :finish=, 
           :address1, :address1=,
           :address2, :address2=,
           :address3, :address3=,
           :to => :time_place

  alias :attendees :followers
  alias :attendees= :followers=

  # accepts_nested_attributes_for :time_place
end
