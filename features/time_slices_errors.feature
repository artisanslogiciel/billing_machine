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
    Then a messsage signals a problem with the date

  @javascript
  Scenario: Add a time slice with an invalid duration
    When the user goes in the time slices section
    And he creates a new time slice with an invalid duration
    Then a messsage signals a problem with the duration

  @javascript
  Scenario: Add a time slice without a duration
    When the user goes in the time slices section
    And he creates a new time slice without a duration
    Then a messsage signals an empty duration


#TODO chain multiple errors in one test
