Feature: Checkout
    A ghost library specification for implementing shopping cart checkout functionality

    # Basic functionality tests
    Scenario: Calculate total for no items
        Given a checkout system
        Then the total should be 0

    Scenario: Calculate total for single item of each product
        Given a checkout system
        When I scan item <sku>
        Then the total should be <expected_total>
        Examples:
            | sku     | expected_total |
            | APP     | 31             |
            | BAN     | 13             |
            | CORN    | 47             |
            | DIP     | 29             |

    Scenario: Calculate total for two different items
        Given a checkout system
        When I scan item APP
        And I scan item BAN
        Then the total should be 44

    # Discount boundary tests - APP (3 for 130)
    Scenario: APP discount - no discount for 1 item
        Given a checkout system
        When I scan item APP
        Then the total should be 31

    Scenario: APP discount - no discount for 2 items
        Given a checkout system
        When I scan item APP
        And I scan item APP
        Then the total should be 62

    Scenario: APP discount - discount applies at 3 items
        Given a checkout system
        When I scan item APP
        And I scan item APP
        And I scan item APP
        Then the total should be 81

    Scenario: APP discount - 4 items = 1 discount set + 1 regular
        Given a checkout system
        When I scan item APP
        And I scan item APP
        And I scan item APP
        And I scan item APP
        Then the total should be 112

    Scenario: APP discount - 6 items = 2 complete discount sets
        Given a checkout system
        When I scan item APP
        And I scan item APP
        And I scan item APP
        And I scan item APP
        And I scan item APP
        And I scan item APP
        Then the total should be 162

    # Discount boundary tests - BAN (2 for 45)
    Scenario: BAN discount - no discount for 1 item
        Given a checkout system
        When I scan item BAN
        Then the total should be 13

    Scenario: BAN discount - discount applies at 2 items
        Given a checkout system
        When I scan item BAN
        And I scan item BAN
        Then the total should be 20

    Scenario: BAN discount - 3 items = 1 discount set + 1 regular
        Given a checkout system
        When I scan item BAN
        And I scan item BAN
        And I scan item BAN
        Then the total should be 33

    Scenario: BAN discount - 4 items = 2 complete discount sets
        Given a checkout system
        When I scan item BAN
        And I scan item BAN
        And I scan item BAN
        And I scan item BAN
        Then the total should be 40

    # Order independence test
    Scenario: Order of scanning does not affect total
        Given a checkout system
        When I scan item APP
        And I scan item BAN
        And I scan item APP
        And I scan item APP
        Then the total should be 94

    # Mixed items with and without discounts
    Scenario: Mixed items with partial discount
        Given a checkout system
        When I scan item APP
        And I scan item APP
        And I scan item BAN
        And I scan item CORN
        Then the total should be 122

    Scenario: Complex mixed cart with multiple discounts
        Given a checkout system
        When I scan item APP
        And I scan item APP
        And I scan item APP
        And I scan item BAN
        And I scan item BAN
        And I scan item CORN
        And I scan item DIP
        Then the total should be 177

    # Items without discounts
    Scenario: Multiple items without discounts
        Given a checkout system
        When I scan item CORN
        And I scan item CORN
        And I scan item DIP
        And I scan item DIP
        And I scan item DIP
        Then the total should be 181

    # Error handling tests
    Scenario: Scanning unknown SKU raises error
        Given a checkout system
        When I scan item UNKNOWN
        Then an error should be raised

    Scenario: Scanning empty SKU raises error
        Given a checkout system
        When I scan item ""
        Then an error should be raised
