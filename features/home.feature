Feature: Home
  Scenario: user can navigate to login page via login button
    Given I am on home page
    When I click on login button
    Then I should be redirected to login page

  Scenario: User can logout via logout button
    Given I login with correct credentials
    When I click on logout button
    Then I should be logged out
