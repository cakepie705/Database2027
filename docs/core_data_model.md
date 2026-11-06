
# NESA CORE Data Model

## Purpose
Document the business entities and relationships in the CORE schema.

## Entity inventory

| Entity | Purpose | Primary key | Foreign keys |
|---|---|---|---|
| REGIONS | Stores regions | region_id | None visible in current review |
| COUNTRIES | Stores countries | country_id | region_id -> REGIONS.region_id |

## Design standards
- Every entity must have a clearly defined primary key.
- Foreign keys must reference the intended parent entity.
- Business identifiers must have documented uniqueness rules.
- Relationships must reflect the actual business rules.
- Table definitions must be validated against the target Snowflake environment.

## Review status
Initial review only. Complete the inventory from the existing SQL before changing the model.
