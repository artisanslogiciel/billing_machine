Feature: Administrator Interface
  As an administrator
  I want to access the admin section from the other pages of the app
  In order to manage the app easely

  @javascript
  Scenario: Access admin page from home page
    Given an existing administrator
    When the administrator is on the home page
    Then the link to the admin section should be visible
    When he clicks on the link
    Then he should be on the admin section