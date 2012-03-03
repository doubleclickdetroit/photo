class Assignment < ActiveRecord::Base
  belongs_to :assignable, :polymorphic => true
  has_one :assignee, :class_name => 'User', 
          :foreign_key => 'id', :primary_key => 'assignee_id'
end
