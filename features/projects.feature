Feature: Project Management
  As a user
  I want to manage projects
  In order to aggregate datas

  @javascript
  Scenario: New project
    Given a user on the projects page
    When he fills the project's name
    And creates a new project
    Then the project is added to the project list

  @javascript
  Scenario: Update project name
    Given an existing project
    And a user on the projects page
    When he edits the project's name
    Then the current project's name should be pre-filled
    When he validates the new name
    Then the project's name is updated
