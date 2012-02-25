module Completable
  extend ActiveSupport::Concern

  included do
    # # .complete? and .due
    # has_one :completion
  end
end
