Feature: Customer Management
  As a user
  I want to manage my customers
  In order to add them to my invoices

  @javascript
  Scenario: New customer
    Given an existing administrator
    When he goes to the customers page
    And he creates a new customer
    And he fills the name, short name, full address, country, IBAN and BIC/SWIFT
    And he saves the customer
    # Commented steps are useless with Active Admin implementation, but for
    # V2 (Customer Vault) they will be usefull
    # Then it's added to the customers list

    # When he edits the customer
    # Then all the fields are filled with the right values

    When the user goes to the invoices page
    And he creates a new invoice
    Then the new customer is usable

  @javascript
  Scenario: Edit customer
    Given an existing customer
    And an existing administrator
    When he goes to the customers page
    And he edits the customer
    And changes his name
    And he saves the customer
    Then the customer's name has changed

  @javascript
  Scenario: Show only customers from same entity
    Given an existing entity
    And an existing administrator from this entity
    And an existing customer from the same entity
    And another existing entity
    And an existing customer from this other entity

    When the administrator is in the admin section
    And he goes to the customers page
    Then he should see the customer from his entity
    And he should not see the customer from another entity

  @javascript
  Scenario: Show correctly zip code begining with 0
    Given an existing administrator
    And an existing customer with zip code 06560
    When the administrator is in the admin section
    And he goes to the customers page
    Then he should see the customer zip code 06560
