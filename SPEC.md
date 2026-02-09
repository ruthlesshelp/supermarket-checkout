# checkout specification v0.1.0

## Overview

`checkout` is a shopping cart price calculator. It computes the total cost of items scanned at a supermarket checkout, applying quantity-based discounts where applicable.

This specification defines the required behavior for implementations in any programming language.

## API

Implementations must provide two functions:

### `scan(sku: string) -> void`

Scans an item and adds it to the shopping cart.

- **Parameter**: `sku` - Stock Keeping Unit identifier (e.g., "APP", "BAN")
- **Returns**: Nothing (void)
- **Errors**: Must raise an error if:
  - SKU is unknown (not in the product catalog)
  - SKU is empty, null, or invalid

### `total() -> number`

Calculates the total price of all scanned items, applying applicable discounts.

- **Returns**: Total price in cents (as integer or decimal, e.g., 130 or 130.00)
- **Note**: Can be called multiple times; should return current total

## Product Catalog

| SKU | Unit Price (cents) | Quantity Discount |
|-----|-------------------|-------------------|
| APP | 31 | 3 for 81 |
| BAN | 13 | 2 for 20 |
| CORN | 47 | none |
| DIP | 29 | none |

## Discount Rules

Quantity discounts apply automatically when the required quantity is reached:

- **APP**: Buy 3 for 81¢ (saves 12¢ vs. 3 × 31¢)
- **BAN**: Buy 2 for 20¢ (saves 6¢ vs. 2 × 13¢)

### Discount calculation

- Discounts apply per complete set of the required quantity
- Remaining items not part of a complete set are charged at unit price
- Order of scanning does not affect the total
- Multiple discount sets can be applied (e.g., 6 APP = 2 discount sets = 260¢)

### Examples

| Scanned Items | Calculation | Total (cents) |
|---------------|-------------|---------------|
| APP × 1 | 1 × 31 | 31 |
| APP × 2 | 2 × 31 | 62 |
| APP × 3 | 3 for 81 (discount) | 81 |
| APP × 4 | 3 for 81 + 1 × 31 | 112 |
| APP × 6 | 2 × (3 for 81) | 162 |
| BAN × 2 | 2 for 20 (discount) | 20 |
| BAN × 3 | 2 for 20 + 1 × 13 | 33 |

## Error Handling

Implementations must raise idiomatic errors for the target language:

- **Unknown SKU**: Scanning an item not in the product catalog (e.g., "INVALID")
- **Invalid input**: Empty string, null, or whitespace-only SKU

Error types should be appropriate for the language (exceptions in Python/Java, Result types in Rust, error returns in Go).

## Additional Requirements

- **Stateful operation**: The checkout system maintains state between `scan()` calls
- **Idempotent total**: Calling `total()` multiple times without scanning new items returns the same value
- **Order independence**: Scanning items in different orders produces the same total (e.g., A, B, A, A equals A, A, A, B)
- **No external dependencies**: Implementations should be self-contained where practical

## Implementation Notes

- Price is expressed in cents to avoid floating-point precision issues
- SKU identifiers are case-sensitive strings
- Consider whether to allow whitespace trimming on SKU input (recommended for robustness)
- Consider how to reset/clear the cart between transactions (not required but useful)
