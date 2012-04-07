class UserMailer < ActionMailer::Base
  default :from => "noreply@app.com"

  def send_invitation(invitation)
    @invitee = invitation.invitee 
    @inviter = invitation.inviter
    @group   = invitation.group
    @message = invitation.message

    subject = "You've been invited by #{@inviter.first} to join #{@group.name}"
    mail :to => @invitee.email, :from => "invitations@app.com", :subject => subject 
  end
end
