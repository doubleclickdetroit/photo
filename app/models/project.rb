class Project < ActiveRecord::Base
  belongs_to :group

  has_many :phases

  # # todo this dynamically for each subclass of
  # # Entity with scopes 
  # def tasks
  #   entities.where :type => 'Task'
  # end

  def to_hash
    # project
    #   id
    #   name 
    #
    #
    #   group
    #     users
    #
    #
    #   phases
    #
    #     phase
    #       name
    #       state
    #
    #       timeline
    #         month
    #           day
    #             entity
    #               comments
    #               ...
    #             entity
    #               comments
    #               ...
    #         month
    #           day
    #             ...
    #  
    #       phase
    #         ...
    
    # todo pretty sure the .try's shouldnt be here...
    hash           = {'name'=>self.name,'id'=>self.id}
    hash['group']  = self.group.try(:to_hash)
    hash['phases'] = self.phases.map(&:to_hash) 

    hash
  end

  def to_json(*args,&block)
    { :project => self.to_hash }.to_json
  end
end
