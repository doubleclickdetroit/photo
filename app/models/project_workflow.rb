class ProjectWorkflow < Project
  # todo there needs to be a way that registrations projects
  # dont show up from the index action from a Group...

  def self.generate_project_from(obj)
    case obj
    when Invitation
      project_from_invitation(obj)
    end
  end

private
  def self.project_from_invitation(invitation)
    proj = Project.new
    # task = Task.new title: "#{invitation.inviter.first} invited you to join #{invitation.group.name}", 
    #                 complete: true, 
    #                 created_at: invitation.created_at
    # proj.entities << task
    proj
  end
end
