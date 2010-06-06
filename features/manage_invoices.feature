Feature: Manage invoices
  In order to Sell Products
  As a store's sales manager
  I want to create and manage sales invoices

  Scenario: Invoice List
    Given the following invoices exist
      | invoice_number |
      | in1234         |
      | in-3456        |
    When I go to the invoices page
    Then I should see "in1234"
    And I should see "in-3456"

  Scenario: Register new invoice
    Given the following stores exist
      | name              |
      | source store      |
      | destination store |
    And the following products exist
      | id | name      |
      |  1 | product A |
      |  2 | product B |
    And the following product batches exist
      | id | batch_code | product_id |
      |  1 | code1      |          1 |
      |  2 | code2      |          2 |
    When I go to the new invoice page
    And I select "destination store" from "Customer"
    And I select "source store" from "Store"
    And I fill in the following within fieldset "Item 1":
      | Sale quantity     | 12   |
      | Free quantity     |  4   |
      | Discount          | 10   |
      | Rate              | 20   |
      | Vat               | 14.5 |
    And I press "Create"

  Scenario: Delete invoice
    Given the following invoices:
      ||
      ||
      ||
      ||
      ||
    When I delete the 3rd invoice
    Then I should see the following invoices:
      ||
      ||
      ||
      ||
