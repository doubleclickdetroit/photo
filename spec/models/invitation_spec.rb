require 'spec_helper'

describe Invitation do
  before(:each) do
    @inviter = Factory(:user)
    @invitee = Factory.build(:user)
    @group   = Factory(:group)

    ActionMailer::Base.deliveries = []
  end

  it 'should send an email to the invitee upon creation' do
    @message = "This is a welcome message to the invitee from the inviter"

    @invitation = Invitation.create :first      => @invitee.first,
                                    :last       => @invitee.last,
                                    :email      => @invitee.email,
                                    :message    => @message,
                                    :group_id   => @group.id,
                                    :inviter_id => @inviter.id

    @email = ActionMailer::Base.deliveries.first

    # system checks
    # todo stash host name in Rails or something
    # todo fix the .first below...?
    @email.from.first.should == "invitations@app.com"
    # group checks
    @email.body.should include(@group.name)

    # inviter checks
    @email.body.should include(@inviter.first)
    @email.body.should include(@message)

    # invitee checks
    # todo fix the .first below...?
    @email.to.first.should   == @invitee.email
    @email.body.should include(@invitee.first)
  end

  it 'should send an email to the invitee upon creation and not show message if none exists' do
    @invitation = Invitation.create :first      => @invitee.first,
                                    :last       => @invitee.last,
                                    :email      => @invitee.email,
                                    :group_id   => @group.id,
                                    :inviter_id => @inviter.id

    @email = ActionMailer::Base.deliveries.first

    # system checks
    # todo stash host name in Rails or something
    # todo fix the .first below...?
    @email.from.first.should == "invitations@app.com"
    # group checks
    @email.body.should include(@group.name)

    # inviter checks
    @email.body.should include(@inviter.first)
    # @email.body.should include(@message)
    @email.body.should_not include("#{@inviter.first} says...")

    # invitee checks
    # todo fix the .first below...?
    @email.to.first.should   == @invitee.email
    @email.body.should include(@invitee.first)
  end
end
