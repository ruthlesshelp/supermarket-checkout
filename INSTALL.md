# Building checkout

`checkout` is a "ghost library"—distributed as a specification, not code. To use it, ask a coding agent to implement it in your language.

## Quick start

Give your coding agent this prompt:

```
Implement the `checkout` library in [LANGUAGE].

1. Read SPEC.md for complete behavior specification
2. Parse tests.feature and generate a test file in [TEST_FRAMEWORK]
3. Implement the scan() and total() functions
4. Run tests until all pass
5. Place implementation in [LOCATION]

Requirements:
- All test cases in tests.feature must pass
- Error handling is mandatory (unknown SKU, invalid input)
- See SPEC.md for API signatures and discount rules
```

Replace `[LANGUAGE]`, `[TEST_FRAMEWORK]`, and `[LOCATION]` with your choices (e.g., "Python", "pytest", "checkout.py").

## What the agent will do

1. **Read SPEC.md** — Understand API, behavior, edge cases, error handling
2. **Parse tests.feature** — Load ~18 test scenarios in Gherkin format
3. **Generate tests** — Create test file in target language's test framework
4. **Implement functions** — Write `scan()` and `total()` with discount logic
5. **Run and iterate** — Fix failures until all tests pass

## Expected output

The agent will create:

- **Implementation file** — e.g., `checkout.py`, `checkout.ts`, `checkout.rs`
- **Test file** — e.g., `test_checkout.py`, `checkout.test.ts`, `checkout_test.go`
- **Optional**: Documentation, examples, or package configuration

## Files in this repository

| File | Purpose |
|------|---------|  
| SPEC.md | Complete behavior specification (API, pricing, discounts, errors) |
| tests.feature | Language-agnostic Gherkin test cases (~18 scenarios) |
| VERIFY.md | Post-implementation verification checklist |

## Verification

After generation, run the test suite. All tests must pass. See [VERIFY.md](VERIFY.md) for detailed verification steps.

## Why this works

Traditional libraries ship code. You trust the maintainer, manage versions, handle dependency conflicts, and hope nothing malicious entered the supply chain.

"Ghost libraries" ship specifications. Your agent generates the implementation locally in your language of choice. You can audit every line. No supply chain vulnerabilities. No version conflicts. No dependency hell. The specification is the single source of truth.

For small, well-defined utilities like this one, the specification is more valuable than any particular implementation. Write the spec once, generate implementations on demand, verify with the included tests.