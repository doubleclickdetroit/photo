require 'spec_helper'

describe Group do
  before(:each) do
    @user1  = Factory(:user)
    @user2  = Factory(:user)
    @group = Factory(:group)
    # @group.members << @user1
    # @membership = Membership.find_by_user_id_and_group_id @user1.id, @group.id
  end

  describe '#to_hash' do
    let(:hash) do
      @group.enroll @user1, :as => 'owner'
      @group.enroll @user2, :as => 'admin'
      @group.to_hash
    end

    it 'should contain the group #id and #name' do
      hash.has_key?('id').should be_true
      hash.has_key?('name').should be_true
    end

    it 'should list its #users with roles' do
      keys = %w(id first last email icon roles).sort
      hash['users'].all? do |u|
        u.keys.sort == keys
      end.should be_true
    end
  end

  describe '#enroll' do
    it 'should enroll a member in a group with a particular role' do
      @group.enroll @user1, :as => 'owner'
    end
  end
end
