# NESA Education Data Platform — Snowflake Architecture

## 1. Purpose

Snowflake will provide the cloud data warehouse for the NESA Education Data Platform.

The platform will separate raw source data, staging data, core relational data, and analytical data into dedicated schemas.

## 2. Database

Database:

`NESA_EDUCATION`

## 3. Schemas

The database will contain four main schemas:

- `RAW`
- `STAGING`
- `CORE`
- `ANALYTICS`

## 4. Data Flow

```text
Source Data
    ↓
RAW
    ↓
STAGING
    ↓
CORE
    ↓
ANALYTICS
    ↓
Reports / Dashboards / Analysis