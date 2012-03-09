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

class Embed < Entity
  has_one :asset, :foreign_key => :entity_id, :dependent => :destroy
  # after_save :associate_asset
  after_initialize :associate_asset

  # { :attachment              => :file,
  #   :attachment=             => :file=,
  #   :attachment_file_name    => :file_name,
  #   :attachment_file_size    => :file_size,
  #   :attachment_content_type => :content_type
  # }.each do |old, new|
  #   delegate old, :to => :asset
  #   self.class_eval do
  #     # if old.to_s.match(/=/)
  #     #   define_method new {|arg| self.send old, arg }
  #     # else
  #       define_method new { send old }
  #     # end
  #   end
  # end

  # remapping paperclip methods on #asset
  # e.g. the following change is made from/to 
  # @embed.asset.attachment_file_name
  # @embed.file_name
  # key/values work as
  # [message sent to asset]/[method on Embed]
  { :attachment => :file,
    :attachment= => :file=,
    :attachment_file_name => :file_name,
    :attachment_file_size => :file_size,
    :attachment_content_type => :content_type,
    :attachment_url => :url
  }.each do |old, new|
    delegate old, :to => :asset

    self.class_eval do
      if old.to_s.match(/=/)
        define_method new do |arg|
          self.send old, arg
        end
      else
        define_method new do 
          self.send old
        end
      end
    end
  end

private
  def associate_asset
    self.asset = Asset.new
  end
end

class Suggestion < Entity
  # todo define this
end
