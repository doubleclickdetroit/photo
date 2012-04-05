class Watching < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity

  delegate :group, :to => :entity

  def to_hash
    attributes
  end
end
