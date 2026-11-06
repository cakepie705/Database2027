-- ============================================
-- NESA Education Data Platform
-- Task 08: Load RAW -> STAGING_RAW
-- Idempotent: truncate before insert
-- ============================================

USE DATABASE NESA_EDUCATION;
USE SCHEMA STAGING;

TRUNCATE TABLE IF EXISTS CSR_EDUCATION_STAGING_RAW;
INSERT INTO CSR_EDUCATION_STAGING_RAW (source_record_id, source_file_name, source_row_number, raw_data, loaded_at)
SELECT source_record_id, source_file_name, source_row_number, raw_data, loaded_at
FROM NESA_EDUCATION.RAW.CSR_EDUCATION_DATA;

TRUNCATE TABLE IF EXISTS NESA_SOURCE_STAGING_RAW;
INSERT INTO NESA_SOURCE_STAGING_RAW (source_record_id, source_file_name, source_row_number, raw_data, loaded_at)
SELECT source_record_id, source_file_name, source_row_number, raw_data, loaded_at
FROM NESA_EDUCATION.RAW.NESA_SOURCE_DATA;

TRUNCATE TABLE IF EXISTS UN_EDUCATION_PARTNERSHIPS_STAGING_RAW;
INSERT INTO UN_EDUCATION_PARTNERSHIPS_STAGING_RAW (source_record_id, source_file_name, source_row_number, raw_data, loaded_at)
SELECT source_record_id, source_file_name, source_row_number, raw_data, loaded_at
FROM NESA_EDUCATION.RAW.UN_EDUCATION_PARTNERSHIPS;