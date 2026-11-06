# NESA-Africa Data Platform
# Naming Conventions

## 1. Purpose

These naming conventions ensure that all Data Engineers use consistent
names across SQLite, Snowflake, SQL, Python, Git, and documentation.

---

## 2. Database Tables

Use:

- lowercase
- snake_case
- singular or plural consistently

For this project, table names will use plural nouns.

Examples:

regions
countries
organisations
programmes
partnerships
beneficiary_metrics
funding
sources
evidence

Do not use:

Regions
REGIONS
regionData
region-data

---

## 3. Columns

Use lowercase snake_case.

Examples:

organisation_id
organisation_name
programme_name
country_id
region_id
start_date
end_date
funding_amount
funding_currency
evidence_grade

Do not use:

OrganisationName
organisationName
Organisation_Name
organisation-name

---

## 4. Primary Keys

Primary keys use:

<table_name>_id

Examples:

region_id
country_id
organisation_id
programme_id
partnership_id
source_id
evidence_id

Primary keys should uniquely identify a record.

---

## 5. Foreign Keys

Foreign keys use the referenced table name followed by `_id`.

Examples:

country_id
region_id
programme_id
organisation_id
source_id

Example:

A programme record contains:

country_id

which references:

countries.country_id

---

## 6. Dates

Use the suffix `_date`.

Examples:

start_date
end_date
publication_date
accessed_date
partnership_start_date
partnership_end_date

Use ISO date format:

YYYY-MM-DD

Example:

2026-09-10

---

## 7. Years

Fields containing only a year use the suffix `_year`.

Examples:

funding_year
measurement_year

Example:

2026

---

## 8. Boolean Fields

Boolean fields should use clear prefixes:

is_
has_

Examples:

is_active
is_verified
has_evidence

Values should be:

TRUE
FALSE

---

## 9. Amounts and Measurements

Use descriptive names.

Examples:

funding_amount
beneficiary_count
metric_value

Do not use vague names such as:

amount
value
number

unless the meaning is completely unambiguous.

---

## 10. Currency

Currency should be stored separately from the monetary amount.

Use:

funding_amount
funding_currency

Example:

funding_amount = 5000000
funding_currency = USD

---

## 11. Evidence

Evidence-related fields should use consistent terminology.

Examples:

evidence_grade
evidence_description
verification_status
actual_or_target

Evidence grades:

A
B
C

---

## 12. Organisation Names

Organisation names should be stored in a standardised form.

Example:

UNICEF

rather than:

United Nations Children's Fund (UNICEF)
Unicef
UNICEF Africa

unless the additional wording represents a distinct organisation or entity.

---

## 13. Region Names

NESA region names should use the approved project terminology.

Examples:

West Africa
East Africa
Central Africa
Southern Africa
North Africa
Horn of Africa
Sahel Region
Indian Ocean Islands
Africans in the Diaspora
Friends of Africa

---

## 14. SQL Files

SQL files should use numbered prefixes so execution order is clear.

Example:

01_create_tables.sql
02_create_indexes.sql
03_insert_reference_data.sql
04_create_views.sql

Use snake_case for the remainder of the filename.

---

## 15. Python Files

Python files use lowercase snake_case.

Examples:

load_raw_data.py
clean_programmes.py
validate_data.py
transform_data.py

---

## 16. Folders

Folders use lowercase snake_case.

Examples:

raw
processed
database
ingestion
cleaning
transformation
validation

---

## 17. Git Branches

Git branches should describe the work being performed.

Format:

feature/<description>

Examples:

feature/database-schema
feature/naming-conventions
feature/data-ingestion
feature/data-cleaning
feature/data-validation

Bug fixes:

fix/<description>

Example:

fix/duplicate-programmes

---

## 18. Git Commits

Commit messages should clearly describe the change.

Examples:

Design initial database schema
Add naming conventions
Add NESA region reference data
Create SQLite tables
Add data validation rules

---

## 19. General Rule

Names should be:

- Clear
- Consistent
- Descriptive
- Machine-readable
- Easy to understand
- Consistent across SQLite and Snowflake

Avoid unnecessary abbreviations.

Avoid spaces.

Avoid special characters.

Use snake_case for database objects and Python files.