Feature: Time slices
  As a user
  I want to get nice error messages
  In order to know how to use the Time Lapse

  Background:
    Given an existing user
    Given an existing project
    Given an existing activity

  @javascript
  Scenario: Add a time slice without a date
    When the user goes in the time slices section
    And he creates a new time slice without a date
    Then a messsage signals an empty date

  @javascript
  Scenario: Add a time slice with an invalid date
    When the user goes in the time slices section
    And he creates a new time slice with an invalid date
    Then a messsage signals a problem with the date

  @javascript
  Scenario: Add a time slice without a duration
    When the user goes in the time slices section
    And he creates a new time slice without a duration
    Then a messsage signals an empty duration
    Then the comment should not be reset by the failure

  @javascript
  Scenario: Add a time slice with an invalid duration
    When the user goes in the time slices section
    And he creates a new time slice with an invalid duration
    Then a messsage signals a problem with the duration
    When he creates a new time slice with a duration too big
    Then a messsage signals a problem with the duration upper limit
    When he creates a new time slice with a negative duration
    Then a messsage signals a problem with the duration lower limit

  @javascript
  Scenario: Do not add an invalid time slice
    When the user goes in the time slices section
    And he creates a new time slice without a date
    Then the time slice is not added to the list
