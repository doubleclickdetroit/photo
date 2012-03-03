class Task < Entity
  has_one :deadline, :foreign_key => :entity_id

  delegate :due, :due=, :to => :deadline
  delegate :complete, :complete=, :to => :deadline
end
