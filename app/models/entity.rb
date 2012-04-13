class Entity < ActiveRecord::Base
  types = {
    Event => {:date => :start,      :icons => :attendees},
    Task  => {:date => :due,        :icons => :assignee},
    Embed => {:date => :created_at, :icons => :created_by},
    Form  => {:date => :created_at, :icons => :created_by}
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

  belongs_to :phase
  delegate :group, :to => :phase

  has_many :comments

  has_many :watchings
  has_many :followers, :through => :watchings, :source => :user 

  after_initialize :associate_asset

  def display_date
    self.send date_method_for_class(self.class)
  end

  def display_avatars
    user_method = users_method_for_class(self.class)
    users = Array(self.send user_method)
    users.map {|a| {:id => a.id, :name => a.name, :icon => a.avatar.url(:icon)} }
  end

  def simple_hash
    # id
    # title
    # text
    # ...
    # avatars
    #   [avatar,avatar]
    
    hash = self.attributes
    hash['avatars'] = display_avatars()
    hash['phase']   = phase.simple_hash
    hash
  end

  def to_hash
    hash = self.simple_hash 

    # haha... ass(ociation)...
    all_additional_attributes.each do |ass|
      obj = self.send(ass)
      hash[ass] = obj.is_a?(Array) ? obj.map(&:to_hash) : obj
    end
    
    hash
  end

  def to_json(full=false)
    hash = full ? to_hash : simple_hash
    hash.to_json
  end

private
  def associate_asset
    raise NoMethodError, "The instance method #{self.class}.associate_asset is not defined for this subclass of Entity" unless self.instance_of?(Entity)
  end

  def self.attach(*args)
    args_hash = args.extract_options!

    if from = args_hash[:from]
      attributes = args.shift

      attributes.each do |att|
        getter, setter = att, att+"="
        delegate getter, setter, :to => from
      end
    else
      args_hash.each do |model, attrs|
        attrs.each do |att|
          getter, setter = att, att+"="
          delegate getter, setter, :to => model
        end
      end
    end
  end

  def self.subclass_from_string(str)
    TYPES_HASH[str]
  end
  def date_method_for_class(klass)
    TYPE_DISPLAY_DATA[klass][:date]
  end
  def users_method_for_class(klass)
    TYPE_DISPLAY_DATA[klass][:icons]
  end

  # created_by/updated_by id's already in #attributes
  @@super_additional_attributes = %w(comments followers) 
  def all_additional_attributes
    subclass_attributes = self.class.class_variable_get :@@own_additional_attributes  
    subclass_attributes + @@super_additional_attributes
  end

end

class Task < Entity
  has_one :deadline, :foreign_key => :entity_id, :dependent => :destroy

  has_one :assignment, :foreign_key => :entity_id, :dependent => :destroy
  has_one :assignee, :through => :assignment, :source => :user 

  def unassign!
    assignment.destroy
    self.assignee   = nil  
    self.assignment = nil  
  end

  @@own_additional_attributes = %w(assignee due complete)
  attach %w(due complete), :from => :deadline

private
  def associate_asset
    self.deadline ||= Deadline.new
  end
end

class Milestone < Task
  # todo define this
end

class Event < Entity
  alias :attendees :followers
  alias :attendees= :followers=

  has_one :duration, :foreign_key => :entity_id, :dependent => :destroy
  has_one :location, :foreign_key => :entity_id, :dependent => :destroy

  # @@own_additional_attributes = {
  #   duration: %w(start finish),
  #   location: %w(address1 address2 address3)
  # }
  # attach @@own_additional_attributes

  duration_attr = %w(start finish)
  location_attr = %w(address1 address2 address3)

  attach duration_attr, :from => :duration
  attach location_attr, :from => :location

  @@own_additional_attributes = duration_attr | location_attr

private
  def associate_asset
    self.duration ||= Duration.new
    self.location ||= Location.new
  end
end

class Embed < Entity
  has_one :asset, :foreign_key => :entity_id, :dependent => :destroy

  @@own_additional_attributes = %w(file_name file_size content_type url)
  attach @@own_additional_attributes, :from => :asset

private
  def associate_asset
    self.asset ||= Asset.new
  end
end

class Suggestion < Entity
  # todo define this
end

class Correspondence < Entity
  # todo define this
end

class Form < Entity
  has_one :form_type, :foreign_key => :entity_id, :class_name => 'SerializedJSON'
  has_one :form_data, :foreign_key => :entity_id, :class_name => 'SerializedJSON', :dependent => :destroy

  @@own_additional_attributes = [] 
  # @@own_additional_attributes = %w(data)
  # attach @@own_additional_attributes, :from => :form_data

  def form_hash
    form_type.to_hash(form_data)
  end

  def to_hash
    super.merge({'_form' => form_hash})
  end

private
  def associate_asset
    # todo this has got to be awfully wrong
    # but its probably going to get left 
    # here through dev :)
    self.form_type ||= FormType.new
    self.form_data ||= FormData.new
  end
end

# brad was definitely here
