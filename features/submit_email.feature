Feature: Submit Email
  In order to be informed of updates
  As a visitor to the site
  I want to submit my email address

  @javascript
  Scenario: Submit email for the first time
    Given my email address is "foo@bar.com" 
    And I have never submitted it before
    When I visit the teaser page
    And submit my email address and info
    Then I am greeted with a thank you message
    And my information is saved

  # @javascript
  # Scenario: Try to re-submit email
  #   Given my email address is "foo@bar.com" 
  #   But I have submitted it before
  #   When I visit the teaser page
  #   And submit my email address and info
  #   Then I am greeted with a thank you message
  #   And my information is not saved twice
