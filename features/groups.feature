Feature: Group CRUD
  In order to manage my company and employees
  As the leader of an organization
  I want User Group management tools

  Scenario: Attempt to view groups while not logged in
    Given I am not logged in
     # todo 
    When I navigate to group management
    # todo
    # Then I am redirected to "/"
    Then I should see "You need to sign in or sign up before continuing."

  Scenario: Having no groups as a new user
    Given there are many groups I do not belong to
    And I am logged in
     # todo 
    When I navigate to group management
    Then I should see no groups


  Scenario: Creating a group as a registered user
    Given there are many groups I do not belong to
    And I am logged in
    # todo 
    When I navigate to group management
    And I click the link "New Group"
    And fill in "Name" with "Test Group"
    And click the button "Save"
    And I click the link "Back"
    Then there should be only one group on the page with the name "Test Group"
    And I should be the owner of the group


  # Scenario: Inviting an existing user to join my group

  # Scenario: Inviting an individual to join my group via email
  #   Given I am logged in and the owner of the group
  #   #todo how should this next step work?
  #   And I click the button "Invite Someone To Your Group"
  #   And fill in the email field
  #   And click the button "Invite" 
  #   When I visit the profile of the user I wish to add
  #   And I click the button "Add User To Your Group"
  #   Then they should receive an email 


  # Scenario: New user joining a group from email

  # Scenario: Existing user joining a group from email
