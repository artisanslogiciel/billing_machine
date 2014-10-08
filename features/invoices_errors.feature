Feature: Invoices 
  As a user
  I want to get an error messages
  In order to know when the invoice is not saved
  
  @javascript
  Scenario: Add an invalid invoice 
 	Given an existing user
 	And an existing customer
 	And an existing payment term
 	When the user goes to the invoices page
    And he creates a new invoice 
	When the new invoice insertion fail
    Then a message signals the fail of the invoice creation
    