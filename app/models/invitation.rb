class Invitation < ActiveRecord::Base
  after_create :after_create_processing

  belongs_to :group
  belongs_to :inviter, :foreign_key => :inviter_id, :class_name => 'User'

  def invitee
    User.new :first => first, :last => last, :email => email
  end

  def invitee_exists?
    !!User.find_by_email(email)
  end

private
  def after_create_processing
    send_invitation
    instantiate_workflow
  end

  def send_invitation
    UserMailer.send_invitation(self).deliver
    # if invitee_exists?
    #   send_non_registration_email
    # else
    #   send_registration_email
    # end
  end
  
  # def send_registration_email
  #   UserMailer.send_invitation(self).deliver
  # end

  # def send_non_registration_email
  #   # todo
  # end

  def instantiate_workflow
    ProjectWorkflow.generate_project_from(self)
  end
end
