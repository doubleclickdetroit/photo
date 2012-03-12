class Comment < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user

  def to_hash
    self.attributes
  end
end
