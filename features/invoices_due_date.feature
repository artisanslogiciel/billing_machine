Feature: Invoice due date Management
  As a user
  I want to set due dates to my invoices
  And to be informed about late payements
  In order to know when to get angry!

  Background:
    Given an existing user

  @javascript
  Scenario: Adding a due date
    Given an existing invoice
    When the user goes to the invoices page
    And he goes on the edit page of the invoice
    And he sets a due date
    And he saves the invoice
    Then a message signals the success of the update
    And he reload the page
    Then the due date is still there
