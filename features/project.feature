Feature: Projects
  In order to display everything associated with a project
  As a member of the project's group
  I want to see and interact with a project

  Scenario: Owner can create a new project
    Given I am logged in
    And I belong to a group
    And I am an owner for that group
    When I visit that group's profile
    And click "New Project"
    And I fill in "Name" with "Test Project"  
    And click "Save"
    Then I should see "Project created successfully"
    And I should see "Test Project"
   
  # Scenario: Admin can create a new timeline


  # Scenario: Only timelines belonging to the group are shown

  # Scenario: A user not belonging to a group cannot see its timelines

  # Scenario: Attempt to view timelines while not logged in
  #   Given I am not logged in
  #    # todo 
  #   When I navigate to group management
  #   # todo
  #   # Then I am redirected to "/"
  #   Then I should see "You need to sign in or sign up before continuing."
