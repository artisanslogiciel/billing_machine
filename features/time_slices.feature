Feature: Time slices
  As a user
  I want to time slices
  In order to monitor the time spent on projects

  Background:
    Given an existing project
    Given an existing activity

  @javascript
  Scenario: Add a time slice
    Given a user on the time slices' section
    When he creates a new time slice
    Then the time slice is added to the list   

  @javascript
  Scenario: Update a time slice
    Given an existing time slice
    And a user on the time slices' section
    When he edits the time slices' duration
    Then the current time slices' duration should be pre-filled
    When he validates the new duration
    Then the time slices' duration is updated
