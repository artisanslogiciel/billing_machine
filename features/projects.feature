Feature: Project Management
  As a user
  I want to manage projects
  In order to aggregate datas

  @javascript
  Scenario: New project
    Given a user on the project page
    When I fill the project name 
    And creates a new project
    Then the project is added to the project list 