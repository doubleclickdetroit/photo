class ProjectWorkflow < Project
  # todo there needs to be a way that registrations projects
  # dont show up from the index action from a Group...
  # probably just a scope for :type => '' or something...

  def self.generate_project_from(obj)
    case obj
    when Invitation
      project_from_invitation(obj)
    end
  end

private
  def self.project_from_invitation(invitation)
    proj = Project.new

    # add task
    task = Task.new title: "#{invitation.inviter.first_name} invited you to join #{invitation.group.name}", 
                    created_at: invitation.created_at
    # todo meta-do this in constructor
    task.complete = true
    proj.entities << task

    # add registration form
    form = RegistrationForm.new title: "Join #{CRM::NAME}", text: "Then be part of #{invitation.group}"
    form.generate_form_data_from(invitation)
    proj.entities << form
    
    # add milestone 
    # add profile details form
    
    # add milestone
    # add link to project

    proj.save

    proj
  end
end
