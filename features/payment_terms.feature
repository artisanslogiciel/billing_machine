Feature: Payment Terms Management
  As an administrator
  I want to create payment term
  In order to use them in the invoices module

  @javascript
  Scenario: Edit Payment Term
    Given an existing administrator
    When the administrator goes to the payment terms administration page
    And he adds a payment term
    And he goes to the new invoice page
    And he creates a new invoice
    Then the payment term is added to the list
