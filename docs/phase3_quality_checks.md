# Phase 3 — Data Quality Checks

## 1. Row Counts
- **CSR**: RAW = 180 rows. STAGING_RAW = 180. STAGING = 180 (1:1).
- **NESA**: RAW = 16 rows. STAGING_RAW = 16. STAGING = 771 rows. (Intentional difference due to flattening the nested JSON nominees).
- **UN**: RAW = 0 rows. STAGING_RAW = 0. STAGING = 0.

## 2. Nulls
- Do not replace NULLs with empty strings or invented values.
- Verify that mandatory fields (e.g., `Country`, `Nominee Name`) are not NULL.

## 3. Duplicates
- **CSR**: Check duplicates on `SOURCE_RECORD_ID`. Do not delete without justification.
- **NESA**: Check duplicates on `(nominee_name, country, achievement)`.

## 4. Types and Dates
- `No.` and `Source Line` must be converted to NUMBER if possible. If non-numeric, leave as NULL.
- `LOADED_AT` is already a TIMESTAMP.

## 5. Text (Whitespace and Case)
- `TRIM()` on all text fields.
- Do not force case (UPPER/LOWER) unless documented.

## 6. Actual vs Target
- Verify that no 'target' or 'planned' field is confused with an actual result.

## 7. Evidence & Verification
- **CSR**: Keep `Potential Nominee` as is. Do not transform it into `verified_nominee`.
- **NESA**: Preserve fields like `achievement`, `image`, etc.