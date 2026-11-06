-- ============================================
-- NESA Education Data Platform
-- Task 06: Snowflake RAW Layer
-- ============================================

USE DATABASE NESA_EDUCATION;
USE SCHEMA RAW;

-- Original NESA dataset
CREATE TABLE IF NOT EXISTS NESA_SOURCE_DATA (
    source_record_id NUMBER AUTOINCREMENT,
    source_file_name VARCHAR,
    source_row_number NUMBER,
    raw_data VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- CSR education research dataset
CREATE TABLE IF NOT EXISTS CSR_EDUCATION_DATA (
    source_record_id NUMBER AUTOINCREMENT,
    source_file_name VARCHAR,
    source_row_number NUMBER,
    raw_data VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- UN / multilateral education partnership dataset
CREATE TABLE IF NOT EXISTS UN_EDUCATION_PARTNERSHIPS (
    source_record_id NUMBER AUTOINCREMENT,
    source_file_name VARCHAR,
    source_row_number NUMBER,
    raw_data VARIANT,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);