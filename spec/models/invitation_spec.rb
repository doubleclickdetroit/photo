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

  # describe '#invitee_exists?' do
  #   before(:each) do
  #     @user = Factory(:user)
  #     @invitation = Factory.build(:invitation)
  #   end

  #   it 'should return false if no User exists for #email' do
  #     @invitation.instance_eval{invitee_exists?}.should be_false
  #   end

  #   it 'should return true if a User exists for #email' do
  #     @invitation.email = @user.email
  #     @invitation.instance_eval{invitee_exists?}.should be_true
  #   end
  # end

  describe '#instantiate_workflow' do
    it 'should create a Project' do
      expect {
        FactoryGirl.create(:invitation,:with_inviter,:with_group)
        # inv = Factory.build(:invitation)
        # inv.inviter = Factory(:user)
        # inv.group   = Factory(:group)
        # inv.save
      }.to change(Project, :count).by(1)
    end
  end

  describe '#send_invitation' do
    it 'should send an email' do
      ActionMailer::Base.deliveries = []

      Factory(:invitation,:with_inviter_and_group)

      ActionMailer::Base.deliveries.should_not be_empty
    end

    # it 'should call #send_registration_email if user is not registered',:focus => true do
    #   Invitation.stub(:invitee_exists?).and_return(false)
    #   Invitation.any_instance.should_receive :send_registration_email
    #   Factory(:invitation,:with_inviter_and_group)
    # end

    # it 'should call #send_non_registration_email if user is registered' do
    #   pending
    #   Invitation.stub(:invitee_exists?).and_return(true)
    #   Invitation.any_instance.should_receive :send_non_registration_email
    #   Factory(:invitation,:with_inviter_and_group)
    # end
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

  describe '#invitee' do
    let(:invitation) { FactoryGirl.build(:invitation,:with_inviter,:with_group) }
    let(:invitee) { invitation.invitee }
    subject { invitee }
    it { should be_a_kind_of(User) }
    
    it 'should have the information from the Invitation' do
      invitee.first.should == invitation.first
      invitee.last.should == invitation.last
      invitee.email.should == invitation.email
    end
  end

  pending 'to_hash'
  pending 'to_json'
end
