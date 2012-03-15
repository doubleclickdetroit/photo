require 'spec_helper'

describe Invitation do

  describe '#inviter' do
    it 'should return a User' do
      user       = Factory(:user)
      invitation = Factory.build(:invitation)
      
      invitation.inviter = user
      invitation.inviter.should be_a_kind_of(User)
      invitation.inviter.should == user
    end
  end

  describe '#group' do
    it 'should return a Group' do
      group      = Factory(:group)
      invitation = Factory.build(:invitation)
      
      invitation.group = group
      invitation.group.should be_a_kind_of(Group)
      invitation.group.should == group
    end
  end

  describe '#send_invitation' do
    pending 'brad figuring out stubs or mocks or something'
  end

end
