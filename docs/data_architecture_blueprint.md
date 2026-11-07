# NESA Education Data Platform — Architecture Blueprint

## 1. Purpose

Build a secure, governed, reliable and maintainable education data platform using PostgreSQL.

The platform will operate separately from NESA's live production system and support data ingestion, transformation, quality management and analytics.

## 2. Technology

- Primary database: PostgreSQL 16
- Database environment: Docker
- Programming language: Python
- Query language: SQL
- Development environment: Visual Studio Code
- Version control: GitHub

## 3. Database Architecture

The platform will use four logical data layers.

### RAW

Stores ingested source data while preserving original values and source information for traceability.

### STAGING

Standardises incoming data and applies validation, cleaning and data-quality checks.

### CORE

Stores structured, trusted education data with defined entities, relationships and constraints.

### ANALYTICS

Provides reporting views and analytical datasets for business intelligence and decision-making.

## 4. Data Flow

Source Systems  
→ Python Ingestion  
→ PostgreSQL RAW  
→ STAGING  
→ CORE  
→ ANALYTICS  
→ Reports and Dashboards

## 5. Architecture Principles

- Preserve source data and traceability.
- Make ingestion repeatable and safe to rerun.
- Validate data before promoting it between layers.
- Apply least-privilege database access.
- Protect sensitive education data.
- Document data definitions and transformations.
- Monitor pipeline failures and data quality.
- Keep development and production changes controlled.

## 6. Operational Requirements

- Record ingestion status and timestamps.
- Detect duplicate and invalid records.
- Validate schemas and business rules.
- Provide clear error logging.
- Support recovery and controlled reprocessing.
- Maintain database backups.

## 7. Architecture Ownership

The Data Architect is responsible for the overall architecture, database design standards, technical direction, documentation and architectural decisions.

## 8. Implementation Status

PostgreSQL is the selected database platform.

Existing SQL scripts, Python code, database schemas, security controls and deployed objects must be reviewed before implementation status is confirmed.