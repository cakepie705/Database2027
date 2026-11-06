-- ============================================
-- NESA Education Data Platform
-- Task 05: Create Database Tables
-- ============================================

-- ============================================
-- 1. REGIONS
-- ============================================

CREATE TABLE IF NOT EXISTS regions (
    region_id INTEGER PRIMARY KEY,
    region_name TEXT NOT NULL UNIQUE,
    description TEXT
);

-- ============================================
-- 2. COUNTRIES
-- ============================================

CREATE TABLE IF NOT EXISTS countries (
    country_id INTEGER PRIMARY KEY,
    country_name TEXT NOT NULL UNIQUE,
    country_code TEXT UNIQUE,
    region_id INTEGER NOT NULL,

    FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
);

-- ============================================
-- 3. ORGANISATIONS
-- ============================================

CREATE TABLE IF NOT EXISTS organisations (
    organisation_id INTEGER PRIMARY KEY,
    organisation_name TEXT NOT NULL UNIQUE,
    organisation_type TEXT,
    country_id INTEGER,

    FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
);

-- ============================================
-- 4. PROGRAMMES
-- ============================================

CREATE TABLE IF NOT EXISTS programmes (
    programme_id INTEGER PRIMARY KEY,
    programme_name TEXT NOT NULL,
    description TEXT,
    organisation_id INTEGER,
    country_id INTEGER,
    region_id INTEGER,
    start_date DATE,
    end_date DATE,
    status TEXT,

    FOREIGN KEY (organisation_id)
        REFERENCES organisations(organisation_id),

    FOREIGN KEY (country_id)
        REFERENCES countries(country_id),

    FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
);

-- ============================================
-- 5. PARTNERSHIPS
-- ============================================

CREATE TABLE IF NOT EXISTS partnerships (
    partnership_id INTEGER PRIMARY KEY,
    programme_id INTEGER NOT NULL,
    organisation_id INTEGER NOT NULL,
    partnership_type TEXT,
    role_description TEXT,
    start_date DATE,
    end_date DATE,

    FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id),

    FOREIGN KEY (organisation_id)
        REFERENCES organisations(organisation_id)
);

-- ============================================
-- 6. BENEFICIARY METRICS
-- ============================================

CREATE TABLE IF NOT EXISTS beneficiary_metrics (
    metric_id INTEGER PRIMARY KEY,
    programme_id INTEGER NOT NULL,
    metric_name TEXT NOT NULL,
    metric_value REAL,
    metric_unit TEXT,
    actual_or_target TEXT,
    measurement_date DATE,
    description TEXT,

    FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id)
);

-- ============================================
-- 7. FUNDING
-- ============================================

CREATE TABLE IF NOT EXISTS funding (
    funding_id INTEGER PRIMARY KEY,
    programme_id INTEGER NOT NULL,
    organisation_id INTEGER,
    funding_amount REAL,
    currency TEXT,
    funding_type TEXT,
    funding_date DATE,
    description TEXT,

    FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id),

    FOREIGN KEY (organisation_id)
        REFERENCES organisations(organisation_id)
);

-- ============================================
-- 8. SOURCES
-- ============================================

CREATE TABLE IF NOT EXISTS sources (
    source_id INTEGER PRIMARY KEY,
    source_name TEXT NOT NULL,
    source_url TEXT,
    source_type TEXT,
    publication_date DATE,
    accessed_date DATE,
    description TEXT
);

-- ============================================
-- 9. EVIDENCE
-- ============================================

CREATE TABLE IF NOT EXISTS evidence (
    evidence_id INTEGER PRIMARY KEY,
    programme_id INTEGER NOT NULL,
    source_id INTEGER NOT NULL,
    evidence_grade TEXT NOT NULL,
    actual_or_target TEXT,
    evidence_description TEXT,
    verification_status TEXT,

    FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id),

    FOREIGN KEY (source_id)
        REFERENCES sources(source_id),

    CHECK (evidence_grade IN ('A', 'B', 'C')),

    CHECK (actual_or_target IN ('actual', 'target'))
);
