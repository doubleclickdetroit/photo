# todo:
# 1 reminders
# 2 heroku
# 3 Container for Entities
# 4 db:seed
#
#
#
#
#
#
# all entities have:
# 1 title
# 2 text
# 3 created_at (place in timeline if no due date)
# 4 comments
# 5 users watching/following/notified
#
# tbd:
# 1 labels? something for filtering
class Entity < ActiveRecord::Base
  attr_accessor :title, :text
  #             :type, :created_at
  #              ^for STI
  has_many :comments, :as => :commentable
  include Notifiable #or Followable or Watchable
end

##############################
########### STI ##############
##############################

# events have:
# 1 location
# 2 a host?
# 3 invitees 
class Event < Entity
  include Attendable
end

# tasks have:
# 1 due date
# 2 completed boolean
# 3 reminders
# 4 assignee(s)
class Task < Entity
  include Assignable # assignment implies need for completion
end

# handles
# 1 assignment
# 2 reminder
# 3 completion
class Assignment < ActiveRecord::Base
  belongs_to :entity

  attr :assignee_id, :reminder_time, :reminder_text, :complete

  def assignee
    User.find assignee_id
  end
end

# assets have:
# 1 an attachment (asset path)
class Asset < Entity
  include Attachable
  # or?
  has_one :attachments
end

class Attachment < ActiveRecord::Base
  belongs_to :asset

  attr :url
end


# polymorphic would allow for models
# other than Entity to also have 
# comments... is this something
# we want to implement?
class Comment
  belongs_to :commentable, :polymorphic => true
end
