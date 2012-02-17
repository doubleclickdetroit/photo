require 'spec_helper'

describe Membership do
  before(:each) do
    @user  = Factory(:user)
    @group = Factory(:group)
    @group.members << @user
    @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
  end

  describe '#for' do
    it 'should be able to be find membership for a given user and group' do
      @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
      @membership.should == Membership.for(@user, @group)
    end
  end
end
