Feature: Administrator Interface
  As an administrator
  I want to access the admin section from the other pages of the app
  In order to manage the app easely

  @javascript
  Scenario: Access admin page from home page
    Given an existing administrator
    When the administrator is on the home page
    Then the link to the admin section should be visible
    When he clicks on the admin link
    Then he should be on the admin section

  @javascript
  Scenario: Access application home page from admin section
    Given an existing administrator
    When the administrator is on the admin section home page
    Then the link to the application home page should be visible
    When he clicks on the application link
    Then he should be on application home page

  @javascript
  Scenario: Don't show admin section tab to non-admin user
    Given an existing user
    When the user is on the home page
    Then he doesn't see the admin section tab

  @javascript
  Scenario: Show only payment terms from same entity
    Given an existing entity
    And an existing administrator from this entity
    And an existing payment term from the same entity
    And another existing entity
    And an existing payment term from this other entity

    When the administrator is in the admin section
    And goes to the payment terms page
    Then he should see the payment term from his entity
    And he should not see the payment term from another entity
