Feature: Time slices
  As a user
  I want to time slices
  In order to monitor the time spent on projects

  Background:
    Given an existing user
    Given an existing project
    Given an existing activity

  @javascript
  Scenario: Add a time slice
    When the user goes in the time slices section
    And he creates a new time slice
    Then a messsage signals the success of the operation
    And the time slice is added to the list

  @javascript
  Scenario: Update a time slice
    Given an existing time slice
    When the user goes in the time slices section
    When he edits the time slices' duration
    Then the current time slices' duration should be pre-filled
    When he validates the new duration
    Then the time slices' duration is updated

  Scenario: Export time slices in CSV
    Given an existing time slice
    When the user goes in the time slices section
    Then he should be able to download the CSV export file
    And downloaded the CSV should be valid with expected information
