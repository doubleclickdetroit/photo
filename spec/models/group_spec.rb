require 'spec_helper'

describe Group do
  before(:each) do
    @user1  = Factory(:user)
    @user2  = Factory(:user)
    @group = Factory(:group)
    # @group.members << @user1
    # @membership = Membership.find_by_user_id_and_group_id @user1.id, @group.id
  end

  describe '.simple_hash' do
    let(:hash) do
      @group.enroll @user1, :as => 'owner'
      @group.enroll @user2, :as => 'admin'
      @group.simple_hash
    end

    keys = Group.new.attributes.keys
    keys << 'projects'
    keys << 'users'

    keys.each do |key|
      it "should include the key #{key}" do
        hash.should include(key)
      end
    end
  end

  # describe '.to_hash' do
  #   let(:hash) do
  #     @group.enroll @user1, :as => 'owner'
  #     @group.enroll @user2, :as => 'admin'
  #     @group.to_hash
  #   end
  # end

  describe '.to_json' do
    it 'should call .simple_hash with no args' do
      @group.should_receive :simple_hash
      @group.should_not_receive :to_hash
      @group.to_json
    end

    it 'should call .full_hash when passed true' do
      @group.should_receive :to_hash
      @group.to_json(true)
    end
  end

  describe '#enroll' do
    it 'should enroll a member in a group with a particular role' do
      @group.enroll @user1, :as => 'owner'
    end
  end


  describe '#invitations' do
    before(:each) do
      3.times { @group.invitations << Factory(:invitation, :with_inviter_and_group) }
    end
    it 'should return an array of invitations' do
      @group.invitations.all?{|i| i.instance_of?(Invitation)}.should be_true
    end
  end

  pending '#users'

end
