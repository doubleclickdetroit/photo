class Entity < ActiveRecord::Base
  TYPES = [Task]
  TYPES_HASH = Hash[TYPES.map{|i| [i.to_s,i]}]

  def self.spawn(*args, &block)
    entity = args.first
    klass = TYPES_HASH[entity[:type]]
    klass.new args.first
  end

  belongs_to :project

  def group
    project.group
  end
end
