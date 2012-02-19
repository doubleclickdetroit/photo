require 'spec_helper'

describe Group do
  before(:each) do
    @user1  = Factory(:user)
    @user2  = Factory(:user)
    @group = Factory(:group)
    # @group.members << @user1
    # @membership = Membership.find_by_user_id_and_group_id @user1.id, @group.id
  end

  describe '#enroll' do
    it 'should enroll a member in a group with a particular role' do
      @group.enroll @user1, :as => 'owner'
    end
  end
end
