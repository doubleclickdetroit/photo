require 'spec_helper'

describe Entity do
  describe Correspondence do
    # we're going to need some mechanism to parse out
    # emails/sms/etc and dump them to this... perhaps
    # that ends up being through a has_many :messages
    # or something...

    # should contain all of the associated messages 
    # but should also have an abbreviated return for
    # use in the UI... well, the json?
    
    # maybe this actually inherits from Container and
    # the associated Messages < Entity ???
    
    # actually, i think this needs discussed more...
    # i think we can do some really awesome stuff 
    # with this, but im not sure it belongs dropped
    # in the timeline the same as everything else...
  end
end
