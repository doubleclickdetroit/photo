Feature: User Profiles
  In order to find information about a user
  As a visitor to the site
  I want to view a specific user's profile

  Scenario: Viewing a user profile
    Given I am a guest to the site
    When I visit a specific user's profile
    Then I should see their personal information
