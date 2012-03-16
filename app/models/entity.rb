class Entity < ActiveRecord::Base
  # todo dynamically
  TYPES = [Task, Event, Embed, Form]
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

  def to_hash(*args)
    hash = self.attributes

    # haha... ass(ociation)...
    all_additional_attributes.each do |ass|
      # true gives you super's attributes
      obj = self.send(ass)
      hash[ass] = obj.is_a?(Array) ? obj.map(&:to_hash) : obj
    end
    
    hash
  end

protected

  def self.attach(*args)
    attributes = args.shift
    from = args.extract_options![:from]

    attributes.each do |att|
      getter, setter = att, att+"="
      delegate getter, setter, :to => from
    end
  end

private

  @@super_additional_attributes = %w(comments followers)
  def all_additional_attributes
    subclass_attributes = self.class.class_variable_get :@@own_additional_attributes  
    subclass_attributes + @@super_additional_attributes
  end

end

class Task < Entity
  has_one :deadline, :foreign_key => :entity_id

  has_one :assignment, :foreign_key => :entity_id
  has_one :assignee, :through => :assignment, :source => :user 

  def unassign!
    assignment.destroy
    self.assignee   = nil  
    self.assignment = nil  
  end

  @@own_additional_attributes = %w(assignee due complete)
  attach %w(due complete), :from => :deadline
end

class Milestone < Task
  # todo define this
end

class Event < Entity
  alias :attendees :followers
  alias :attendees= :followers=

  has_one :time_place, :foreign_key => :entity_id

  @@own_additional_attributes = %w(start finish address1 address2 address3)
  attach @@own_additional_attributes, :from => :time_place
end

class Embed < Entity
  has_one :asset, :foreign_key => :entity_id, :dependent => :destroy
  # after_save :associate_asset
  after_initialize :associate_asset

  @@own_additional_attributes = %w(file_name file_size content_type url)
  attach @@own_additional_attributes, :from => :asset

private
  def associate_asset
    self.asset = Asset.new
  end
end

class Suggestion < Entity
  # todo define this
end

class Correspondence < Entity
  # todo define this
end

class Form < Entity
  has_one :form_data, :foreign_key => :entity_id

  @@own_additional_attributes = %w(data)
  attach @@own_additional_attributes, :from => :form_data
end
