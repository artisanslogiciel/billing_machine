Feature: Invoice Management
  As a user
  I want to create invoices
  In order to get paid!

  @javascript
  Scenario: New invoice for existing customer
    Given an existing user
    And an existing customer
    And an existing payment term
    When the user goes to the invoices page
    And he creates a new invoice
    And he fills the reference, the date and the payment terms
    And he chooses the customer
    And he fills a line with "Bidule", "4", "€", "10"
    Then the new line's total should be "40.00€"
    When he adds the new line
    Then the total duty is "40.00€"
    And he fills a line with "Machin truc", "8", "€", "20"
    Then the new line's total should be "160.00€"
    When he adds the new line
    Then the total duty is "200.00€"
    And the vat due is "40.00€"
    And the total all taxes included is "240.00€"
    When he saves the invoice
    Then it's added to the invoice list

  @javascript
  Scenario: Edit invoice
    Given an existing user
    And an existing invoice
    When the user goes to the invoices page
    And he edits the invoice
    And changes the label
    When he saves the invoice
    Then the invoices's label has changed
