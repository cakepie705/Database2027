-- ============================================
-- NESA Education Data Platform
-- Task 09: Transform CSR -> _CLEAN
-- ============================================

USE DATABASE NESA_EDUCATION;
USE SCHEMA STAGING;

TRUNCATE TABLE IF EXISTS CSR_EDUCATION_DATA_CLEAN;

INSERT INTO CSR_EDUCATION_DATA_CLEAN (
    source_record_id, 
    source_file_name, 
    source_row_number, 
    raw_data, 
    loaded_at, 
    staged_at,
    classification, 
    contribution_to_african_education, 
    country, 
    icon_category, 
    no, 
    potential_nominee, 
    source_line, 
    version
)
SELECT
    source_record_id,
    source_file_name,
    source_row_number,
    raw_data,
    loaded_at,
    CURRENT_TIMESTAMP(),
    TRIM(raw_data:Classification::STRING),
    TRIM(raw_data:"Contribution to African Education (2006–2026)"::STRING),
    TRIM(raw_data:Country::STRING),
    TRIM(raw_data:"Icon Category"::STRING),
    TRY_TO_NUMBER(raw_data:"No."::STRING),
    TRIM(raw_data:"Potential Nominee"::STRING),
    TRY_TO_NUMBER(raw_data:"Source Line"::STRING),
    TRIM(raw_data:Version::STRING)
FROM NESA_EDUCATION.STAGING.CSR_EDUCATION_STAGING_RAW;