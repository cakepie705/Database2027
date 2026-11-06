# Phase 3 — Transformation Log

## General Rules
- Never modify RAW tables.
- Preserve `SOURCE_RECORD_ID`, `SOURCE_FILE_NAME`, `SOURCE_ROW_NUMBER`, `LOADED_AT`.
- Do not invent values. Keep NULLs as NULL.
- The 'Potential Nominee' field must remain a research/register field, not a verified nominee.

## TR-001 — CSR_EDUCATION_DATA → CSR_EDUCATION_STAGING
- **Source**: `RAW.CSR_EDUCATION_DATA`
- **Target**: `STAGING.CSR_EDUCATION_STAGING`
- **Rule**: Extract keys from the JSON `RAW_DATA` into relational columns.
- **Target Columns**:
  - `classification` (VARCHAR)
  - `contribution_to_african_education` (VARCHAR)
  - `country` (VARCHAR)
  - `icon_category` (VARCHAR)
  - `no` (NUMBER)
  - `potential_nominee` (VARCHAR) — *Register/Research field only*
  - `source_line` (NUMBER)
  - `version` (VARCHAR)
- **Lineage**: `source_record_id`, `source_file_name`, `source_row_number`, `loaded_at`.
- **Cleaning**: `TRIM()` on text fields. Do not convert `potential_nominee` to a verified nominee.

## TR-002 — NESA_SOURCE_DATA → NESA_SOURCE_STAGING
- **Source**: `RAW.NESA_SOURCE_DATA`
- **Target**: `STAGING.NESA_SOURCE_DATA_CLEAN`
- **Rule**: Flatten the flat-keys JSON structure (e.g., `subCategories/0/nominees/0/name`). Extract only valid nominees with a name.
- **Result**: 16 RAW rows generate 771 STAGING rows (intentional).
- **Lineage**: `source_record_id`, `source_file_name`, `source_row_number`, `loaded_at`, `staged_at`.

## TR-003 — UN_EDUCATION_PARTNERSHIPS
- **Source**: `RAW.UN_EDUCATION_PARTNERSHIPS`
- **Target**: `STAGING.UN_EDUCATION_STAGING`
- **Rule**: No transformation. Table remains empty because the approved source dataset is unavailable.