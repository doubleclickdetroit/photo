class Project < ActiveRecord::Base
  belongs_to :group
  has_many :entities

  def tasks
    self.entities.where :type => 'Task'
  end

  def entities_by_month_and_date
    hash = {}

    self.entities.each do |ent|
      date = case ent
             when Event
               ent.start
             when Task
               ent.due
             when Embed
               ent.created_at
             end
      month, day = date.month, date.day

      hash[month] ||= {}
      hash[month][day] ||= []
      hash[month][day] << ent.to_hash(:associations => true)
    end

    hash
  end

  def timeline_hash
    entities_by_month_and_date 
  end

  def to_hash
    # project
    #   id
    #   name 
    #
    #   group
    #     users
    #
    #   timeline
    #     month
    #       day
    #         entity
    #           comments
    #         entity
    #           comments
    #     month
    #       day
    #         ...
    
    hash             = {'name'=>self.name,'id'=>self.id}
    hash['group']    = self.group.try(:to_hash)
    hash['timeline'] = self.timeline_hash

    hash
  end

  alias :to_json_orig :to_json
  def to_json(*args,&block)
    { :project => self.to_hash }.to_json
  end
end
