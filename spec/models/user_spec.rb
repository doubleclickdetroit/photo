require 'spec_helper'

describe User do
  before(:each) do
    @user  = Factory(:user)
    @group = Factory(:group)
    @group.members << @user
    @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
  end

  describe '#memberships_for' do
    it 'should be able to be find membership for a given group' do
      @membership.should == @user.membership_for(@group)
    end
  end

  describe '#roles_for' do
    it 'should be able to be find roles for a given group' do
      @membership.roles.should == @user.roles_for(@group)
    end
  end

  describe '#enroll_in' do
    it 'should enroll a member in a group with a particular role' do
      @user.enroll_in @group, :as => 'owner'
    end
  end
end
