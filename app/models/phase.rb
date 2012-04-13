class Phase < ActiveRecord::Base
  belongs_to :project
  delegate :group, :to => :project

  has_many :entities

  def entities_by_month_and_date
    hash = {}

    self.entities.each do |ent|
      date = ent.display_date
      month, day = date.month, date.day

      hash[month]      ||= {}
      hash[month][day] ||= []
      hash[month][day] << ent.simple_hash
    end

    hash
  end

  def timeline_hash
    entities_by_month_and_date 
  end

  def simple_hash
    # phase
    #   id
    #   name 
    #   state
    hash = self.attributes
  end

  def to_hash
    # phase
    #   id
    #   name 
    #   state
    #
    #   timeline
    #     month
    #       day
    #         entity
    #           comments
    #           ...
    #         entity
    #           comments
    #           ...
    #     month
    #       day
    #         ...
    
    hash = {
      # 'id'=>self.id,
      # 'name'=>self.name,
      # 'state'=>self.state
    }
    hash['timeline'] = self.timeline_hash

    hash
  end

  def to_json(full=false)
    hash = full ? to_hash : simple_hash
    hash.to_json
  end

end
