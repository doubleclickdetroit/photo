Feature: Tasks
  In order to keep track of what is done and what needs to be completed
  As a member of the project's group
  I want to be able to view and create tasks 

  Scenario: Owner of a group can view the tasks of a project from the project view
    Given I am logged in
    And I belong to a group
    And I am an "owner" for that group
    And that group already has a project named "Cucumber Project"
    And that project already has several tasks
    When I visit my group's profile
    And click "Cucumber Project"
    Then I should see all the tasks' titles 

  Scenario Outline: All group members add an task to a project 
    Given I am logged in
    And I belong to a group
    And I am an "<role>" for that group
    And that group already has a project named "Cucumber Project"
    When I visit my group's profile
    And click "Cucumber Project"
    And click "New task"
    And fill in "Title" with "Test task"
    And fill in "Text" with "Test task copy text"
    And select "Task" from "Type"
    And press "Save"
    # todo check redirect to project page
    Then I should see "Task was successfully created."

    Examples:
      | role      |
      | owner     |
      | admin     |
      | associate |


  # todo selenium confirm dialog
  # @js
  # Scenario Outline: Only owners and admins may delete an task from a project 
  #   Given I am logged in
  #   And I belong to a group
  #   And I am an "<role>" for that group
  #   And that group already has a project named "Cucumber Project"
  #   And that project already has an task
  #   When I visit my group's profile
  #   And click "Cucumber Project"
  #   # todo this cleaner
  #   # And click "Destroy"
  #   # And confirm the dialog
  #   And click "Destroy" and confirm the dialog
  #   # todo check redirect to project page
  #   Then I should see "<message>"

  #   Examples:
  #     | role      | message                          |
  #     | owner     | Task was successfully created. | 
  #     | admin     | Task was successfully created. |
  #     | associate | failure message | 
