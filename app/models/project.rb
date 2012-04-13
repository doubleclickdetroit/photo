class Project < ActiveRecord::Base
  belongs_to :group

  has_many :phases

  def to_hash
    # # todo implement the following:
    # project
    #   id
    #   name 
    #
    #   group
    #     id
    #     name
    #
    #   phases
    #     phase
    #       id
    #       name
    #       state
    #     phase
    #       ...
    
    hash           = {'name'=>self.name,'id'=>self.id}
    hash['group']  = self.group.to_hash
    hash['phases'] = self.phases.map(&:to_hash) 

    hash
  end

  def to_json(*args,&block)
    { :project => self.to_hash }.to_json
  end
end
