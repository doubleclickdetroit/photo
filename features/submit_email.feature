@teaser
Feature: Submit Email
  In order to be informed of updates
  As a visitor to the site
  I want to submit my email address

  @javascript
  Scenario: Submit email for the first time
    Given I have the following information
      |first|last |email                        |
      |Brad |Chase|bchase@doubleclickdetroit.com|
    And I have never submitted it before
    When I visit the teaser page
    And submit my email address and info
    Then I am greeted with a thank you message
    And my information is saved
