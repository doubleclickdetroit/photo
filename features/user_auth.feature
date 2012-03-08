@auth
Feature: Registration
  In order to gain access to the site 
  As a visitor to the site without a login
  I want to sign up for an account  

  Scenario: Successful account sign-up 
    Given I have the following information
      |first|last |email      |group_name|password|
      |brad |chase|foo@bar.com|foobar    |asdfasdf|
    And I am not a registered user 
    When I visit the home page
    And click "Sign up" 
    And fill in and submit the form with my user data 
    Then I see "Welcome! You have signed up successfully."
