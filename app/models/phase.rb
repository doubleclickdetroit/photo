class Phase < ActiveRecord::Base
  belongs_to :project
  delegate :group, :to => :project

  has_many :entities

  def entities_by_month_and_date
    hash = {}

    self.entities.each do |ent|
      puts "####################{ent.inspect}"
      date = ent.display_date
      puts "####################{date}"
      month, day = date.month, date.day

      hash[month]      ||= {}
      hash[month][day] ||= []
      hash[month][day] << ent.to_hash(:associations => true)
    end

    hash
  end

  def timeline_hash
    entities_by_month_and_date 
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

end
