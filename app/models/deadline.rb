class Deadline < ActiveRecord::Base
  belongs_to :entity

  # alias :task :entity
end
