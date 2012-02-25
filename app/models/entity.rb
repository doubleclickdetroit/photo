class Entity < ActiveRecord::Base
  belongs_to :project

  TYPES = %w[task]

  def group
    project.group
  end
end
