-- ============================================
-- NESA Education Data Platform
-- Task 06: Snowflake CORE Layer
-- ============================================

USE DATABASE NESA_EDUCATION;
USE SCHEMA CORE;


-- ============================================
-- 1. REGIONS
-- ============================================

CREATE TABLE IF NOT EXISTS REGIONS (
    region_id NUMBER NOT NULL,
    region_name VARCHAR NOT NULL,
    description VARCHAR,

    CONSTRAINT pk_regions
        PRIMARY KEY (region_id),

    CONSTRAINT uq_regions_name
        UNIQUE (region_name)
);


-- ============================================
-- 2. COUNTRIES
-- ============================================

CREATE TABLE IF NOT EXISTS COUNTRIES (
    country_id NUMBER NOT NULL,
    country_name VARCHAR NOT NULL,
    country_code VARCHAR,
    region_id NUMBER NOT NULL,

    CONSTRAINT pk_countries
        PRIMARY KEY (country_id),

    CONSTRAINT uq_countries_name
        UNIQUE (country_name),

    CONSTRAINT uq_countries_code
        UNIQUE (country_code),

    CONSTRAINT fk_countries_region
        FOREIGN KEY (region_id)
        REFERENCES REGIONS(region_id)
);


-- ============================================
-- 3. ORGANISATIONS
-- ============================================

CREATE TABLE IF NOT EXISTS ORGANISATIONS (
    organisation_id NUMBER NOT NULL,
    organisation_name VARCHAR NOT NULL,
    organisation_type VARCHAR,
    country_id NUMBER,

    CONSTRAINT pk_organisations
        PRIMARY KEY (organisation_id),

    CONSTRAINT uq_organisations_name
        UNIQUE (organisation_name),

    CONSTRAINT fk_organisations_country
        FOREIGN KEY (country_id)
        REFERENCES COUNTRIES(country_id)
);


-- ============================================
-- 4. PROGRAMMES
-- ============================================

CREATE TABLE IF NOT EXISTS PROGRAMMES (
    programme_id NUMBER NOT NULL,
    programme_name VARCHAR NOT NULL,
    description VARCHAR,
    organisation_id NUMBER,
    country_id NUMBER,
    region_id NUMBER,
    start_date DATE,
    end_date DATE,
    status VARCHAR,

    CONSTRAINT pk_programmes
        PRIMARY KEY (programme_id),

    CONSTRAINT fk_programmes_organisation
        FOREIGN KEY (organisation_id)
        REFERENCES ORGANISATIONS(organisation_id),

    CONSTRAINT fk_programmes_country
        FOREIGN KEY (country_id)
        REFERENCES COUNTRIES(country_id),

    CONSTRAINT fk_programmes_region
        FOREIGN KEY (region_id)
        REFERENCES REGIONS(region_id)
);


-- ============================================
-- 5. PARTNERSHIPS
-- ============================================

CREATE TABLE IF NOT EXISTS PARTNERSHIPS (
    partnership_id NUMBER NOT NULL,
    programme_id NUMBER NOT NULL,
    organisation_id NUMBER NOT NULL,
    partnership_type VARCHAR,
    role_description VARCHAR,
    start_date DATE,
    end_date DATE,

    CONSTRAINT pk_partnerships
        PRIMARY KEY (partnership_id),

    CONSTRAINT fk_partnerships_programme
        FOREIGN KEY (programme_id)
        REFERENCES PROGRAMMES(programme_id),

    CONSTRAINT fk_partnerships_organisation
        FOREIGN KEY (organisation_id)
        REFERENCES ORGANISATIONS(organisation_id)
);


-- ============================================
-- 6. BENEFICIARY_METRICS
-- ============================================

CREATE TABLE IF NOT EXISTS BENEFICIARY_METRICS (
    metric_id NUMBER NOT NULL,
    programme_id NUMBER NOT NULL,
    metric_name VARCHAR NOT NULL,
    metric_value FLOAT,
    metric_unit VARCHAR,
    actual_or_target VARCHAR,
    measurement_date DATE,
    description VARCHAR,

    CONSTRAINT pk_beneficiary_metrics
        PRIMARY KEY (metric_id),

    CONSTRAINT fk_metrics_programme
        FOREIGN KEY (programme_id)
        REFERENCES PROGRAMMES(programme_id)
);


-- ============================================
-- 7. FUNDING
-- ============================================

CREATE TABLE IF NOT EXISTS FUNDING (
    funding_id NUMBER NOT NULL,
    programme_id NUMBER NOT NULL,
    organisation_id NUMBER,
    funding_amount FLOAT,
    currency VARCHAR,
    funding_type VARCHAR,
    funding_date DATE,
    description VARCHAR,

    CONSTRAINT pk_funding
        PRIMARY KEY (funding_id),

    CONSTRAINT fk_funding_programme
        FOREIGN KEY (programme_id)
        REFERENCES PROGRAMMES(programme_id),

    CONSTRAINT fk_funding_organisation
        FOREIGN KEY (organisation_id)
        REFERENCES ORGANISATIONS(organisation_id)
);


-- ============================================
-- 8. SOURCES
-- ============================================

CREATE TABLE IF NOT EXISTS SOURCES (
    source_id NUMBER NOT NULL,
    source_name VARCHAR NOT NULL,
    source_url VARCHAR,
    source_type VARCHAR,
    publication_date DATE,
    accessed_date DATE,
    description VARCHAR,

    CONSTRAINT pk_sources
        PRIMARY KEY (source_id)
);


-- ============================================
-- 9. EVIDENCE
-- ============================================

CREATE TABLE IF NOT EXISTS EVIDENCE (
    evidence_id NUMBER NOT NULL,
    programme_id NUMBER NOT NULL,
    source_id NUMBER NOT NULL,
    evidence_grade VARCHAR NOT NULL,
    actual_or_target VARCHAR,
    evidence_description VARCHAR,
    verification_status VARCHAR,

    CONSTRAINT pk_evidence
        PRIMARY KEY (evidence_id),

    CONSTRAINT fk_evidence_programme
        FOREIGN KEY (programme_id)
        REFERENCES PROGRAMMES(programme_id),

    CONSTRAINT fk_evidence_source
        FOREIGN KEY (source_id)
        REFERENCES SOURCES(source_id),

    CONSTRAINT chk_evidence_grade
        CHECK (evidence_grade IN ('A', 'B', 'C')),

    CONSTRAINT chk_evidence_actual_target
        CHECK (
            actual_or_target IS NULL
            OR actual_or_target IN ('actual', 'target')
        )
);

-- ============================================
-- 10. NOMINEES
-- (Extension of CORE for Phase 3 data)
-- ============================================

CREATE TABLE IF NOT EXISTS NOMINEES (
    nominee_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    nominee_name VARCHAR NOT NULL,
    country_id NUMBER,
    state VARCHAR,
    image_url VARCHAR,
    source_system VARCHAR, -- 'NESA' or 'CSR'

    CONSTRAINT pk_nominees PRIMARY KEY (nominee_id),
    CONSTRAINT fk_nominees_country FOREIGN KEY (country_id) REFERENCES COUNTRIES(country_id)
);


-- ============================================
-- 11. AWARDS
-- (Extension of CORE for NESA Categories)
-- ============================================

CREATE TABLE IF NOT EXISTS AWARDS (
    award_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    award_title VARCHAR NOT NULL,
    award_description VARCHAR,

    CONSTRAINT pk_awards PRIMARY KEY (award_id),
    CONSTRAINT uq_awards_title UNIQUE (award_title)
);


-- ============================================
-- 12. NOMINATIONS
-- (Fact table linking Nominees to Awards)
-- ============================================

CREATE TABLE IF NOT EXISTS NOMINATIONS (
    nomination_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    award_id NUMBER NOT NULL,
    nominee_id NUMBER NOT NULL,
    achievement_description VARCHAR,
    source_id NUMBER, -- Links to the SOURCES table (already in CORE)

    CONSTRAINT pk_nominations PRIMARY KEY (nomination_id),
    CONSTRAINT fk_nominations_award FOREIGN KEY (award_id) REFERENCES AWARDS(award_id),
    CONSTRAINT fk_nominations_nominee FOREIGN KEY (nominee_id) REFERENCES NOMINEES(nominee_id),
    CONSTRAINT fk_nominations_source FOREIGN KEY (source_id) REFERENCES SOURCES(source_id)
);


-- ============================================
-- 13. CSR_CONTRIBUTIONS
-- (Extension of CORE for CSR data)
-- ============================================

CREATE TABLE IF NOT EXISTS CSR_CONTRIBUTIONS (
    contribution_id NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    potential_nominee VARCHAR NOT NULL,
    classification VARCHAR,
    icon_category VARCHAR,
    contribution_description VARCHAR,
    source_id NUMBER, -- Links to the SOURCES table

    CONSTRAINT pk_csr_contributions PRIMARY KEY (contribution_id),
    CONSTRAINT fk_csr_source FOREIGN KEY (source_id) REFERENCES SOURCES(source_id)
);