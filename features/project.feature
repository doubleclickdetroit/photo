# Feature: Projects
#   In order to display everything associated with a project
#   As a member of the project's group
#   I want to see and interact with a project
# 
#   Scenario: Owner of a group can create a new project
#     Given I am logged in
#     And I belong to a group
#     And I am an "owner" for that group
#     When I visit my group's profile
#     And click "New Project"
#     And I fill in "Name" with "Test Project"  
#     And press "Save"
#     # todo land on groups page
#     Then I should see "Project was successfully created."
#     And I should see "Test Project"
#    
#   Scenario: Admin of a group can create a new project
#     Given I am logged in
#     And I belong to a group
#     And I am an "admin" for that group
#     When I visit my group's profile
#     And click "New Project"
#     And I fill in "Name" with "Test Project"  
#     And press "Save"
#     # todo land on groups page
#     Then I should see "Project was successfully created."
#     And I should see "Test Project"
# 
#   Scenario: Associate of a group cannot create a new project
#     Given I am logged in
#     And I belong to a group
#     And I am an "associate" for that group
#     When I visit my group's profile
#     And click "New Project"
#     And I fill in "Name" with "Test Project"  
#     And press "Save"
#     Then I should be redirected to "/"
#     And I should see "You are not authorized to access this page."
#   
#   Scenario: Only projects belonging to the group are shown
#     Given I am logged in
#     And I belong to a group
#     And I am an "admin" for that group
#     And there are many projects that do not belong to my group
#     When I visit my group's profile
#     Then I shouldn't see the projects that don't belong
# 
#   Scenario: Attempt to view projects while not logged in
#     Given I am not logged in
#     And there is a group with a project
#     When I navigate to that project
#     Then I should be redirected to "/users/sign_in"
#     And I should see "You need to sign in or sign up before continuing."
