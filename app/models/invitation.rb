class Invitation < ActiveRecord::Base
  belongs_to :group
  belongs_to :inviter, :foreign_key => :inviter_id, :class_name => 'User'

  after_create :send_invitation

  def send_invitation
    UserMailer.send_invitation(self).deliver
  end
end
