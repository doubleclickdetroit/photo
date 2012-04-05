class Comment < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user

  delegate :group, :to => :entity

  def to_hash
    self.attributes
  end
end
