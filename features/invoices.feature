Feature: Invoice Management
  As a user
  I want to create invoices
  In order to get paid!

  @javascript
  Scenario: New invoice for existing customer
    Given an existing user
    And an existing customer
    When the user goes to the invoices page
    And he creates a new invoice
    And he fills the reference, the date and the payment terms
    And he adds a line "Bidule", "4", "€", "10"
    And he adds a line "Machin truc", "8", "€", "20"
    Then the total duty is "200.00"
    And the total all taxes included is "240.00"
    And the balance due is "240.00"
