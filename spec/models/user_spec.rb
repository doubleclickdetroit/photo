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

  describe '#avatar' do
    describe '#url' do
      describe 'is not defined' do
        it 'should default to the default 30x30 when passed :icon' do
          @user.avatar.url(:icon).should == "/assets/default_icon_avatar.png"
        end

        it 'should default to the default 100x100 when passed :small' do
          @user.avatar.url(:small).should == "/assets/default_small_avatar.png"
        end
      end

      describe 'is defined' do
        before(:each) do
          @user = Factory(:user, :with_avatar)
        end

        it 'should return a URL for an icon when passed :icon' do
          @user.avatar.url(:icon).should match('icon')
        end

        it 'should return a URL for a small image when passed :small' do
          @user.avatar.url(:small).should match('small')
        end
      end
    end
  end
end
