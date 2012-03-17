class Entity < ActiveRecord::Base
  types = {
    Event => {:date => :start,      :icons => :attendees},
    Task  => {:date => :due,        :icons => :assignee},
    Embed => {:date => :created_at, :icons => :created_by}
  }
  # types.each {|type| types[type.to_s] = type}

  TYPE_DISPLAY_DATA = types
  TYPES = TYPE_DISPLAY_DATA.keys 
  TYPES_HASH = Hash[TYPES.map{|i| [i.to_s,i]}]

  def self.spawn(*args, &block)
    entity = args.first
    klass = subclass_from_string(entity[:type])
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

  def display_date
    self.send date_method_for_class(self.class)
  end

  def display_avatars
    user_method = users_method_for_class(self.class)
    users = Array(self.send user_method)
    users.map {|a| {:id => a.id, :name => a.name, :icon => a.avatar.url(:icon)} }
  end

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

private

  def self.attach(*args)
    attributes = args.shift
    from = args.extract_options![:from]

    attributes.each do |att|
      getter, setter = att, att+"="
      delegate getter, setter, :to => from
    end
  end

  def subclass_from_string(str)
    TYPES_HASH[str]
  end
  def date_method_for_class(klass)
    TYPE_DISPLAY_DATA[klass][:date]
  end
  def users_method_for_class(klass)
    TYPE_DISPLAY_DATA[klass][:icons]
  end

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
