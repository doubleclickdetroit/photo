module Assignable
  extend ActiveSupport::Concern

  included do
    # has_one :assignment

    # delagate :assignee, :to => :assignment
  end
end
