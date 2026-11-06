-- ============================================================
-- NESA Education Data Platform
-- Snowflake Analytics Views
-- ============================================================

USE DATABASE NESA_EDUCATION;

-- ============================================================
-- 1. Programme Impact Summary
-- ============================================================

CREATE OR REPLACE VIEW ANALYTICS.PROGRAMME_IMPACT_SUMMARY AS
SELECT
    p.programme_id,
    p.programme_name,
    p.status AS programme_status,
    o.organisation_name,
    c.country_name,
    r.region_name,
    bm.metric_name,
    bm.metric_value,
    bm.metric_unit,
    bm.actual_or_target,
    bm.measurement_date
FROM NESA_EDUCATION.CORE.PROGRAMMES p
LEFT JOIN NESA_EDUCATION.CORE.ORGANISATIONS o
    ON p.organisation_id = o.organisation_id
LEFT JOIN NESA_EDUCATION.CORE.COUNTRIES c
    ON p.country_id = c.country_id
LEFT JOIN NESA_EDUCATION.CORE.REGIONS r
    ON p.region_id = r.region_id
LEFT JOIN NESA_EDUCATION.CORE.BENEFICIARY_METRICS bm
    ON p.programme_id = bm.programme_id;


-- ============================================================
-- 2. Regional Impact Summary
-- ============================================================

CREATE OR REPLACE VIEW ANALYTICS.REGIONAL_IMPACT_SUMMARY AS
SELECT
    r.region_id,
    r.region_name,

    SUM(
        CASE
            WHEN bm.actual_or_target = 'actual'
            THEN bm.metric_value
            ELSE 0
        END
    ) AS total_actual_metric_value,

    SUM(
        CASE
            WHEN bm.actual_or_target = 'target'
            THEN bm.metric_value
            ELSE 0
        END
    ) AS total_target_metric_value

FROM NESA_EDUCATION.CORE.REGIONS r

LEFT JOIN NESA_EDUCATION.CORE.PROGRAMMES p
    ON r.region_id = p.region_id

LEFT JOIN NESA_EDUCATION.CORE.BENEFICIARY_METRICS bm
    ON p.programme_id = bm.programme_id

GROUP BY
    r.region_id,
    r.region_name;