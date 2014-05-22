Feature: Customer Management
  As a user
  I want to manage my customers
  In order to add them to my invoices

  @javascript
  Scenario: New customer
    Given an existing user
    When the user goes to the customers page
    And he creates a new customer
    And he fills the name, short name, full address, country, CEDEX, IBAN and BIC/SWIFT
    And he saves the customer
    Then it's added to the customers list

    When he edits the customer
    Then all the fields are filled with the right values

    When the user goes to the invoices page
    And he creates a new invoice
    Then the new customer is usable

  @javascript
  Scenario: Edit customer
    Given an existing user
    And an existing customer
    When the user goes to the customers page
    And he edits the customer
    And changes his name
    And he saves the customer
    Then the customer's name has changed
