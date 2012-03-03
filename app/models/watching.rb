class Watching < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity

  scope :assignments, where(:assigned => true)

  def unassign!
    self.update_attribute :assigned, false
  end

  def assign!
    self.update_attribute :assigned, true
  end
end
