# supermarket-checkout

A shopping cart price calculator that computes the total cost of items scanned at a supermarket checkout, applying quantity-based discounts where applicable.

**This is a "ghost library"** — distributed as a specification, not code. Ask your coding agent to generate an implementation in any programming language.

## Quick Start

Give your coding agent this prompt:

```
Implement the `checkout` library in [LANGUAGE].

1. Read SPEC.md for complete behavior specification
2. Parse tests.feature and generate a test file in [TEST_FRAMEWORK]
3. Implement the scan() and total() functions
4. Run tests until all pass
5. Place implementation in [LOCATION]
```

Replace `[LANGUAGE]`, `[TEST_FRAMEWORK]`, and `[LOCATION]` with your choices (e.g., "Python", "pytest", "checkout.py").

See [INSTALL.md](INSTALL.md) for detailed instructions.

## API Overview

Implementations provide two functions:

| Function | Description |
|----------|-------------|
| `scan(sku)` | Scans an item and adds it to the cart |
| `total()` | Returns the total price in cents, with discounts applied |

## Product Catalog

| SKU | Unit Price | Discount | Description of item |
|-----|------------|----------|---------------------|
| APP | 31¢ | 3 for 81¢ | Apple |
| BAN | 13¢ | 2 for 20¢ | Banana |
| CORN | 47¢ | — | Can of corn |
| DIP | 29¢ | — | Dipping sauce |

## Repository Files

| File | Purpose |
|------|---------|
| [SPEC.md](SPEC.md) | Complete behavior specification (API, pricing, discounts, errors) |
| [tests.feature](tests.feature) | Language-agnostic Gherkin test cases (18 scenarios) |
| [INSTALL.md](INSTALL.md) | Agent prompts and build instructions |
| [VERIFY.md](VERIFY.md) | Post-implementation verification checklist |

## Why Ghost Libraries?

Traditional libraries ship code — you manage versions, handle dependency conflicts, and trust the supply chain.

Ghost libraries ship specifications. Your agent generates the implementation locally. You can audit every line. No supply chain vulnerabilities. No version conflicts. The specification is the single source of truth.

## License

This library is based on the idea of `whenwords` presented by Drew Breunig, here: 
https://github.com/dbreunig/whenwords

MIT — see [LICENSE](LICENSE) for details.
