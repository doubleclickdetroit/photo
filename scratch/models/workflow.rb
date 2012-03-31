# 1 - users of the system should be able to make their own
# workflows... im not sure what that looks like.
#
# 2 - there need to be system workflows that allow for 
# things like registration and other one-offs
#
class ProjectWorkflow < Project
end

class PhaseWorkflow < Phase
end


# so... how would a user communicate to the app what a 
# workflow could be? i imagine it would make sense to
# use our Form Entity if the UI fits a timeline?
#
#
# ********** THIS *************
# sooooo maybe creating a workflow is a matter of dragging
# Entities around a fake Timeline (relative date offsets)
# with the ability to fill them in with vars
#
# e.g. [[company]], [[client]], [[inviter]] 
#
#
# so then maybe Workflow is a subclass of Project/Phase?
# the route tells the controller to treat the project
# by offset instead of by date and enables the use of 
# variables. 
#
# benefits of this are that the UI and db persistence 
# are the same/similar to Projects/Phases

# i think there still need to be one-offs, like registration
# ...but they are probably still just unique in that they
# contain specialized Entities that cant be added by a normal
# user e.g. sign_up, profile_details
#
#
# registration workflow instantiaties 
#   - for a Group
#   - by an Invitation
#
# so, how does a Workflow relate to its related models
# (e.g. Group/Invitation)? in the case of Group, i suppose
# its easy: upon instantiation of the Workflow (the copying
# of it into a given Group as a Project/Phase) it just looks
# to see what Group the resulting Project is going to
#
# what about Invitation then? ...
#
# when a user invites someone else, the "Project" of
# registration is instantiated, filling in all the values 



# # - ACTION
#   L - RESULT
#
#
# 1 - Project is instantiated from ProjectWorkflow resulting in:
#   a - Task marked completed "you were invited by [[inviter]]"
#   b - Registration Entity 
#
# 2 - Registration Completed resulting in:
#   a - Milestone creation (marked complete)
#   b - Profile details Entity
#
# 3 - Details complete
#   a - Milestone creation (marked complete)
#   b - link to join project

# ^ this implies several things:
# 1 awareness of completion by Entity
# 2 Milestones linked to Entity completion
# 3 creation of other Entities by completion of Entity

# i guess this is sort of about registration too....

# tl;dr a workflow should be able to spit out a Project in the
# context of a Group/User etc
# user is prompted for vars that cannot be inferred?



# ok, so what does this object look like for an Invitation

# current_user  = User that is me
# current_group = the group context im in?

@invitation = Invitation.new :inviter => current_user, :invitee => {:first => 'First', :last => 'Last', :email => 'a@b.com'}

# smart constructor
@registration_project = ProjectWorkflow.generate_project_from(@invitation)

@registration_project.entities
# => [
#      <#Task title="#{inviter.first} invites #{invitee.first} to #{current_group}">,
#      <#Registration title="Join #{Rails.appname}">
#    ]
