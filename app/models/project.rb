class Project < ActiveRecord::Base
  belongs_to :group
  has_many :entities

  def tasks
    entities.where(:type => 'Task')
  end
end
