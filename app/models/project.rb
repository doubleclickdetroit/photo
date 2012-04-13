class Project < ActiveRecord::Base
  belongs_to :group

  has_many :phases

  def simple_hash(with_phases=true)
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
    # todo this in Group
    hash['group']  = {'name'=>group.name,'id'=>group.id}
    hash['phases'] = self.phases.map(&:simple_hash) if with_phases

    hash
  end

  def to_hash
    hash = simple_hash(false) # false omits phases
    hash['phases'] = self.phases.map(&:to_hash)
    hash
  end

  def to_json(full=false)
    # { :project => self.to_hash }.to_json
    hash = full ? to_hash : simple_hash
    hash.to_json
  end

end
