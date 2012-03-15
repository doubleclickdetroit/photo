# # todo sending invitations
# Feature: Inviting users to groups
#   In order to add users to my group
#   As an admin/owner of my group
#   I want to be able to send invitations

# user is invited to a group by their email
# if email exists in system
#   1. send email to that account
# else
#   2. send email inviting them to sign up
#   if user has existing account other another email
#     3. allow them to sign in and be added to the group
#   end
# end

# upon creation of Invitation, an email should be sent
# to the recipient, allowing them to join the group

Feature: Invitation to a group (non-member)
  In order to join a group
  As a non-member of the site
  I want to receive an email inviting me to join

  Scenario:
    Given my information is as follows
      |first|last |email      |
      |Brad |Chase|foo@bar.com|
    When I am invited to join a group named "DoubleClick Detroit"
    Then I should receive an email invitation
    And it should contain the group name  
    And my first name
 
# Feature: Invitation to a group (existing member by proper email)
# 
# Feature: Invitation to a group (existing member by wrong email)
