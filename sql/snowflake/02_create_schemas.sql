-- ============================================
-- NESA Education Data Platform
-- Task 06: Snowflake Schemas
-- ============================================

USE DATABASE NESA_EDUCATION;

-- Raw source data
CREATE SCHEMA IF NOT EXISTS RAW;

-- Data cleaning and standardisation
CREATE SCHEMA IF NOT EXISTS STAGING;

-- Structured business data model
CREATE SCHEMA IF NOT EXISTS CORE;

-- Reporting and analytics
CREATE SCHEMA IF NOT EXISTS ANALYTICS;