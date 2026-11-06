
# NESA RAW Layer Design

## Purpose
The RAW layer stores source records ingested into Snowflake.

## Current source tables
- NESA_SOURCE_DATA
- CSR_EDUCATION_DATA
- UN_EDUCATION_PARTNERSHIPS

## Data retention and traceability
- Preserve source values as received.
- Record the source file name.
- Record the source row number when available.
- Record the ingestion timestamp.
- Keep a traceable relationship between loaded records and their source.

## Ingestion principles
- Design loads to be safely repeatable.
- Detect duplicate source records where appropriate.
- Record failed and successful ingestion runs.
- Do not silently discard invalid source records.
- Restrict access to sensitive source data.

## Validation before production
- Verify source file formats and schemas.
- Confirm expected source columns and record counts.
- Test duplicate handling and reload behaviour.
- Confirm retention and access policies.
