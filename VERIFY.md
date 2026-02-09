# Verifying your checkout implementation

After generating the library, verify correctness.

## 1. Run the generated tests

The agent should have created a test file from tests.feature. Run it with your language's test runner:

```bash
# Python
pytest test_checkout.py

# TypeScript/JavaScript
npm test
# or
vitest run

# Rust
cargo test

# Go
go test ./...

# Ruby
rspec spec/
# or
ruby -Itest test_checkout.rb

# Java
mvn test
# or
gradle test
```

## 2. Check coverage

All functions must be tested:

| Function | Test scenarios |
|----------|----------------|
| scan() | ~18 scenarios (basic, discounts, boundaries, errors) |
| total() | ~18 scenarios (all test cases verify total calculation) |

The tests.feature file contains approximately 18 test scenarios covering:
- Basic functionality (4 products)
- Discount boundaries (APP, BAN)
- Order independence
- Mixed carts
- Error handling (unknown SKU, empty input)

If your test run shows significantly fewer tests, the agent may have missed some scenarios.

## 3. Manual smoke test

Quick sanity checks in a REPL or script:

## 4. Edge cases to spot-check

### Error handling
- Scanning unknown SKU (e.g., `scan("UNKNOWN")`) → should raise error
- Scanning empty string (`scan("")`) → should raise error

### Discount boundaries
- 2 APP → 100 (no discount)
- 3 APP → 130 (discount applied)
- 4 APP → 180 (one discount + one regular)

### Order independence
- APP, BAN, APP, APP → same total as APP × 3, BAN

## 5. Implementation checklist

Before shipping:

- [ ] All tests.feature tests pass (~18 scenarios)
- [ ] Error handling is implemented for unknown SKUs and invalid input
- [ ] Errors are idiomatic (exceptions, Result types, etc.)
- [ ] Discount logic correctly handles boundaries (2 vs. 3 APP, 1 vs. 2 BAN)
- [ ] Code is idiomatic for target language
- [ ] No external dependencies (or minimal, documented ones)

## 6. Optional enhancements

The spec defines core behavior.

Any enhancements must not break spec-defined behavior. All `tests.feature` tests must still pass.

## Troubleshooting

**Discount calculations are off:**
Verify the discount logic correctly identifies complete sets. For APP (3 for 130), you need exactly 3 to get the discount. 2 APP = 100, 3 APP = 130, 4 APP = 180 (one set of 3 for 130, plus one at 50).

**Error tests fail:**
Ensure your implementation raises errors (not returns null/undefined) for unknown SKUs and invalid input. The error type should be idiomatic for your language (exceptions in Python/Java, panics or Results in Rust, errors in Go).

**Order independence test fails:**
Make sure you're accumulating counts of each SKU, not processing items sequentially. Scanning APP, BAN, APP, APP should produce the same result as APP, APP, APP, BAN.
