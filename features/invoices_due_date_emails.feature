Feature: Invoice due date emails
  As a user
  For the invoices
  I want to receive emails about the very late payments
  In order to know when to get really angry!

  Background:
    Given an existing user who wants to be notified about late invoices payments
  @current
  Scenario: Email when due date passed by 16 days
    Given an existing unpaid invoice
    And its due date is 16 days ago
    When the scheduled task runs at 03:00:00Z
    Then the user is notified
