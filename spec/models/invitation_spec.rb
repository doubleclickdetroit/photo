require 'spec_helper'

describe Invitation do

  describe '#inviter' do
    it 'should return a User' do
      user      = Factory(:user)
      invitation = Factory.build(:invitation)
      
      invitation.inviter = user
      invitation.inviter.should == user
    end
  end

  describe '#group' do
    it 'should return a Group' do
      group      = Factory(:group)
      invitation = Factory.build(:invitation)
      
      invitation.group = group
      invitation.group.should == group
    end
  end

  # todo move this to user_mailer_spec
  describe '#send_invitation' do
    before(:each) do
      ActionMailer::Base.deliveries = []

      @inviter = Factory(:user)
      @invitee = Factory.build(:user)
      @group   = Factory(:group)

      @message = "This is a welcome message to the invitee from the inviter"

      @invitation_hash = { :first      => @invitee.first,
                           :last       => @invitee.last,
                           :email      => @invitee.email,
                           :message    => @message,
                           :group_id   => @group.id,
                           :inviter_id => @inviter.id }

      @invitation = Invitation.create @invitation_hash

      @email = ActionMailer::Base.deliveries.last
    end

    it 'should be from invitations@app.com' do
      # todo stash host name in Rails or something
      # todo fix the .first below...?
      @email.from.first.should == "invitations@app.com"
    end

    it 'should include the group name' do
      # group checks
      @email.body.should include(@group.name)
    end

    it "should include the inviter's first name" do
      # inviter checks
      @email.body.should include(@inviter.first)
    end

    it 'should be sent to the invitee' do
      # todo fix the .first below...?
      @email.to.first.should == @invitee.email
    end

    it "should contain the invitee's first name" do
      @email.body.should include(@invitee.first)
    end

    it 'should send an email with message' do
      @email.body.should include("#{@inviter.first} says...")
      @email.body.should include(@message)
      @email.body.should include(@inviter.avatar.url(:small))
    end

    it 'should show no message if none exists' do
      ActionMailer::Base.deliveries = []
      @invitation_hash.delete(:message)
      Invitation.create @invitation_hash

      @email = ActionMailer::Base.deliveries.last

      @email.body.should_not include("#{@inviter.first} says...")
      @email.body.should_not include(@message)
    end

    # todo links for join group/register
    it 'should say "Join Group" if the invitee is already registered by that email' do
      ActionMailer::Base.deliveries = []
      @invitation_hash[:email] = Factory(:user).email
      @invitee = Invitation.create @invitation_hash

      @email = ActionMailer::Base.deliveries.last

      @email.body.should_not include('Register')
    end

    it 'should say "Register & Join Group" if the user is not registered by that email' do
      @email.body.should include('Register &amp; Join Group')
    end

  end

end
