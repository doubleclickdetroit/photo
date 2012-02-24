require 'spec_helper'

describe User do
  before(:each) do
    @user  = Factory(:user)
    @group = Factory(:group)
    @group.members << @user
    @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
  end

  describe '#membership_for' do
    it 'should return nil if user is not member of the group' do
      @membership.delete
      @user.membership_for(@group).should be_nil
    end

    it 'should be able to be find membership for a given group' do
      @membership.should == @user.membership_for(@group)
    end
  end

  describe '#roles_for' do
    it 'should return [] if user is not a member of the group' do
      @membership.delete
      @user.roles_for(@group).should == []
    end

    it 'should be able to be find roles for a given group' do
      @membership.roles.should == @user.roles_for(@group)
    end
  end

  describe '#enroll_in' do
    it 'should throw an error without :as => :role_symbol' do
      lambda { @user.enroll_in @group }.should raise_error
    end

    it 'should enroll a member in a group with a particular role' do
      @user.enroll_in @group, :as => :owner
    end
  end

  describe '#has_role?' do
    it 'should throw an error without :for => group_instance' do
      lambda { @user.has_role?(:owner) }.should raise_error
    end

    it 'should be able to check for a single role' do
      @user.enroll_in @group, :as => :owner
      @user.has_role?(:owner, :for => @group).should be_true
    end

    it 'should be able to check for multiple roles' do
      @user.enroll_in @group, :as => :owner
      @user.has_role?([:owner,:admin], :for => @group).should be_true
    end

    it 'should return false for miss with single role' do
      @user.enroll_in @group, :as => :associate
      @user.has_role?(:owner, :for => @group).should be_false
    end

    it 'should return false for miss with multiple roles' do
      @user.enroll_in @group, :as => :associate
      @user.has_role?([:owner,:admin], :for => @group).should be_false
    end

    it 'should return false if user is not member of the group being tested' do
      @user.has_role?(:owner, :for => @group).should be_false
    end
  end
end
