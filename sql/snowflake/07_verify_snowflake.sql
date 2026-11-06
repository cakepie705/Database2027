-- ============================================
-- NESA Education Data Platform
-- Task 06: Snowflake Verification
-- ============================================

-- Select database
USE DATABASE NESA_EDUCATION;


-- ============================================
-- 1. Verify schemas
-- ============================================

SHOW SCHEMAS;


-- ============================================
-- 2. Verify CORE tables
-- ============================================

SHOW TABLES IN SCHEMA NESA_EDUCATION.CORE;


-- ============================================
-- 3. Verify RAW tables
-- ============================================

SHOW TABLES IN SCHEMA NESA_EDUCATION.RAW;


-- ============================================
-- 4. Verify STAGING tables
-- ============================================

SHOW TABLES IN SCHEMA NESA_EDUCATION.STAGING;


-- ============================================
-- 5. Verify ANALYTICS views
-- ============================================

SHOW VIEWS IN SCHEMA NESA_EDUCATION.ANALYTICS;