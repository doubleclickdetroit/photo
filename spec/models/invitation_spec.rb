require 'spec_helper'

describe Invitation do

  describe 'callbacks' do
    let(:invitation) { Factory.build(:invitation) }
    describe 'after_create' do
      it 'should call #send_invitation' do
        invitation.stub(:instantiate_workflow)
        invitation.should_receive :send_invitation
        invitation.save
      end

      it 'should call #instantiate_workflow' do
        invitation.stub(:send_invitation)
        invitation.should_receive :instantiate_workflow
        invitation.save
      end
    end
  end

  describe '#invitee_exists?' do
    before(:each) do
      @user = Factory(:user)
      @invitation = Factory.build(:invitation)
    end

    it 'should return false if no User exists for #email' do
      @invitation.instance_eval{invitee_exists?}.should be_false
    end

    it 'should return true if a User exists for #email' do
      @invitation.email = @user.email
      @invitation.instance_eval{invitee_exists?}.should be_true
    end
  end

  describe '#instantiate_workflow' do
    it 'should create a Project' do
      expect {
        inv = Factory.build(:invitation)
        inv.inviter = Factory(:user)
        inv.group   = Factory(:group)
        inv.save
      }.to change(Project, :count).by(1)
    end
  end

  describe '#send_invitation' do
    it 'should send an email' do
      ActionMailer::Base.deliveries = []

      inv = Factory.build(:invitation)
      inv.inviter = Factory(:user)
      inv.group   = Factory(:group)
      inv.save

      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

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

end

# describe_internally Invitation do
# end
