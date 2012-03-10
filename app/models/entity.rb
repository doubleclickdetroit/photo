class Entity < ActiveRecord::Base
  # todo dynamically
  TYPES = [Task]
  TYPES_HASH = Hash[TYPES.map{|i| [i.to_s,i]}]

  def self.spawn(*args, &block)
    entity = args.first
    klass = TYPES_HASH[entity[:type]]
    klass.new args.first
  end

  # todo these have not been set in the controller
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

  def self.attach(*args)
    attributes   = args.shift
    from = args.extract_options![:from]

    attributes.each do |att|
      getter, setter = att, att+"="
      delegate getter, setter, :to => from
    end
  end

  def self.additional_attributes(include_super=false)
    %w(comments followers assignee)
  end

  def to_hash(*args)
    hash = self.attributes

    # haha... ass(ociation)...
    self.class.additional_attributes(true).each do |ass|
      # true gives you super's attributes
      hash[ass] = self.send ass
    end
    
    hash
  end
end

class Task < Entity
  has_one :deadline, :foreign_key => :entity_id

  # handles delegation of methods to associations
  # and #to_hash functionality for Entity subclasses
  def self.additional_attributes(include_super=false)
    %w(due complete) + ( include_super ? super : [] )
  end
  attach self.additional_attributes, :from => :deadline
end

class Event < Entity
  alias :attendees :followers
  alias :attendees= :followers=

  has_one :time_place, :foreign_key => :entity_id

  # handles delegation of methods to associations
  # and #to_hash functionality for Entity subclasses
  def self.additional_attributes(include_super=false)
    %w(start finish address1 address2 address3) + ( include_super ? super : [] )
  end
  attach self.additional_attributes, :from => :time_place
end

class Embed < Entity
  has_one :asset, :foreign_key => :entity_id, :dependent => :destroy
  # after_save :associate_asset
  after_initialize :associate_asset


  # todo? #file/file= ???
  # todo the following shouldnt allow setters... 
  #
  # handles delegation of methods to associations
  # and #to_hash functionality for Entity subclasses
  def self.additional_attributes(include_super=false)
    %w(file_name file_size content_type url) + ( include_super ? super : [] )
  end
  attach self.additional_attributes, :from => :asset

private
  def associate_asset
    self.asset = Asset.new
  end
end

class Suggestion < Entity
  # todo define this
end

class Correspondence < Entity
end
