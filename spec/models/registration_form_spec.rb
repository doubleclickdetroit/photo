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

  describe RegistrationForm.new.form_type do
    it { should be_a_new_record } # overrides AR
  end
end
