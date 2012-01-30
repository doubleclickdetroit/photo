require 'spec_helper'

describe Group do
  before(:each) { @group = Factory(:group) }

  before(:each) { @user1 = Factory(:user) }
  before(:each) { @user2 = Factory(:user) }

  it 'has many members' do
    @group.members << @user1
    @group.members << @user2
    @group.members.should == [@user1,@user2]
  end

  it 'can only have members added by admin'
  it 'can only have members removed by admin'
end
