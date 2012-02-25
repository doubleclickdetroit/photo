Feature: Project Entities
  In order to track specifics of a project 
  As a member of the project's group
  I want to be able to view entities to track tasks, events, etc 

  Scenario: Owner of a group can view the entities of a project from the project view
    Given I am logged in
    And I belong to a group
    And I am an "owner" for that group
    And that group already has a project named "Cucumber Project"
    And that project already has several entities
    When I visit my group's profile
    And click "Cucumber Project"
    Then I should see all the entities' titles 

  Scenario: Owner of a group can add an entity to a project 
    Given I am logged in
    And I belong to a group
    And I am an "owner" for that group
    And that group already has a project named "Cucumber Project"
    When I visit my group's profile
    And click "Cucumber Project"
    And click "New Entity"
    And fill in "Title" with "Test Entity"
    And fill in "Text" with "Test entity copy text"
    And select "Task" from "Type"
    And press "Save"
    # todo check redirect to project page
    # Then I should be on "Entity was successfully created."
    Then I should see "Entity was successfully created."
