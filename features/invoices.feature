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
    Then he sees the customer's infos
    And he fills a line with "Bidule", "4", "€", "10"
    Then the new line's total should be "40.00€"
    When he adds the new line
    Then the total duty is "40.00€"
    And he fills a line with "Machin truc", "8", "€", "20"
    Then the new line's total should be "160.00€"
    When he adds the new line
    Then the total duty is "200.00€"
    And the VAT due is "40.00€"
    And the total all taxes included is "240.00€"
    When he saves the new invoice
    Then a message signal the succes of the creation
    Then it's added to the invoice list

  @javascript
  @exclude_from_ci
  Scenario: Edit invoice # fails on CI, excluded meanwhile more investigation is done, issue #87
    Given an existing user
    And an existing invoice
    When the user goes to the invoices page
    And he goes on the edit page of the invoice
    And changes the label
    When he saves the invoice
    Then the invoices's label has changed

  @javascript
  Scenario: New invoice with default VAT rate
    Given an existing user
    When the user goes to the invoices page
    And he creates a new invoice
    # we check the default value
    Then the VAT rate is "20"
    When he saves the new invoice
    # we check the AJAX returned value
    Then the VAT rate is "20"

  @javascript
  Scenario: Existing invoice with non default VAT rate
    Given an existing user
    And an existing invoice with a "19.6"% VAT rate
    When the user goes to the invoices page
    And he goes on the edit page of the invoice
    # value should be preserved
    Then the VAT rate is "19.6"

  @javascript
  Scenario: New invoice with non default VAT rate
    Given an existing user
    When the user goes to the invoices page
    And he creates a new invoice
    And he fills a new line with "Bidule", "1", "€", "100"
    And he adds the new line
    And he changes the VAT rate to "19.6"
    And he saves the invoice
    Then the VAT rate is "19.6"
    And the VAT due is "19.60€"
    And the total all taxes included is "119.60€"

  @javascript
  Scenario: Change VAT to a non defaut value
    Given an existing user
    And an existing invoice
    When the user goes to the invoices page
    And he goes on the edit page of the invoice
    And he fills a new line with "Bidule", "1", "€", "100"
    And he adds the new line
    And he changes the VAT rate to "19.6"
    And he saves the invoice
    Then the VAT rate is "19.6"
    And the VAT due is "19.60€"
    And the total all taxes included is "119.60€"

  @javascript
  Scenario: Change values without saving(test live preview)
    Given an existing user
    When the user goes to the invoices page
    And he creates a new invoice
    And he fills a new line with "Bidule", "2", "€", "50"
    Then the new line total is "100.00€"
    When he adds the new line
    And he edits the line
    And he fills the existing line with "Bidule", "10", "€", "100"
    Then the existing line total is "1000.00€"
    And the VAT due is "200.00€"
    And the total all taxes included is "1200.00€"
    And he changes the VAT rate to "19.6"
    And the VAT due is "196.00€"
    And the total all taxes included is "1196.00€"

  @javascript
  Scenario: Export invoices in CSV
    Given an existing user
    And an existing invoice
    When the user goes to the invoices page
    Then he finds and clicks on the download CSV export file

  @javascript
  Scenario: Existing unpaid invoice set to paid
    Given an existing user
    And an existing invoice
    When the user goes to the invoices page
    Then the invoice paid status is marked unpaid
    And he set the invoice as paid
    Then the invoice paid status is marked paid
    And a message signal that the invoice is set to paid
    And the invoice status is set to paid
    And can't set the invoice as paid again

  @javascript
  Scenario: Existing paid invoice set to unpaid
    Given an existing user
    And an existing paid invoice
    When the user goes to the invoices page
    Then the invoice paid status is marked paid
    And can't set the invoice as paid again
    And he goes on the edit page of the invoice
    When he marks the invoice as unpaid
    And he saves the invoice
    Then a message signal the succes of the update
    And the invoice status is set to unpaid