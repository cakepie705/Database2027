
# NESA Education Data Platform — Architecture Blueprint

## 1. Purpose

Build a governed, reliable and maintainable education data platform using Snowflake.

## 2. Database

- Database: NESA_EDUCATION

## 3. Data Layers

### RAW
Stores ingested source data and preserves source values for traceability.

### STAGING
Standardises incoming data and applies data-quality checks before modelling.

### CORE
Stores structured, trusted education data with defined entities and relationships.

### ANALYTICS
Provides governed views and datasets for reporting and analysis.

## 4. Data Flow

Source Systems
    -> Ingestion
    -> RAW
    -> STAGING
    -> CORE
    -> ANALYTICS
    -> Reports and Dashboards

## 5. Architecture Principles

- Preserve traceability to source data.
- Make ingestion repeatable and safe to rerun.
- Validate data before promoting it between layers.
- Apply least-privilege access controls.
- Protect sensitive education data.
- Document data definitions and transformations.
- Monitor pipeline failures and data quality.
- Keep development and production changes controlled.

## 6. Operational Requirements

- Record ingestion status and timestamps.
- Detect duplicate and invalid records.
- Validate schemas and important business rules.
- Provide clear error logging.
- Support recovery and controlled reprocessing.

## 7. Implementation Status

This document defines the initial target architecture.
Existing SQL scripts, Python code, security controls and deployed Snowflake objects must be inspected before implementation status is confirmed.
