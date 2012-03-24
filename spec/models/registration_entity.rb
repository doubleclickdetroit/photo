require 'spec_helper'

describe RegistrationForm do
  # todo stash this somewhere sensical
  before(:each) do
    @owner     = Factory(:user)
    # @admin     = Factory(:user)
    # @associate = Factory(:user)

    @group     = Factory(:group)
    
    # todo this in a factory
    @owner.enroll_in @group, :as => :owner
    # @admin.enroll_in @group, :as => :admin
    # @associate.enroll_in @group, :as => :associate
  end
  
  it { should be_false } 
end
