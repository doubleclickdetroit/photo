require 'spec_helper'

describe Membership do
  describe 'role logic -' do
    before(:each) do
      @membership = Factory(:membership)
    end

    describe 'roles' do
      subject { @membership.roles }
      it { should be_empty }
    end

    describe 'roles=' do
      it 'should allow assignment of an array of role symbol(s)' do
        arr = [:admin]
        @membership.roles = arr
        @membership.roles.should == arr
      end

      it 'should ignore bogus roles' do
        @membership.roles = [:admin, :bogus]
        @membership.roles.should == [:admin]
      end
    end

    describe 'role?' do
      it 'should return true if the arg sym is in #roles' do
        @membership.roles = [:admin]
        @membership.role?(:admin).should be_true
      end

      it 'should return false if the arg sym is not in #roles' do
        @membership.role?(:admin).should be_false
      end
    end

    describe 'valid roles -' do
      it 'should persist the following roles' do 
        roles = [:owner, :admin, :associate]
        roles.each do |role|
          arr = [role]
          @membership.roles = arr
          @membership.roles.should == arr
        end
      end
    end

    # describe 'roles<<' do
    #   it 'should push a role into #roles' do
    #     @membership.roles << :admin
    #     @membership.roles.should == [:admin]
    #   end

    #   it 'should ignore bogus roles' do
    #     pending
    #     @membership.roles = [:admin, :bogus]
    #     @membership.roles.should == [:admin]
    #   end
    # end
  end

  describe '#for' do
    before(:each) do
      @user  = Factory(:user)
      @group = Factory(:group)
      @group.members << @user
      @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
    end

    it 'should be able to be find membership for a given user and group' do
      @membership = Membership.find_by_user_id_and_group_id @user.id, @group.id
      @membership.should == Membership.for(@user, @group)
    end
  end
end
