-- ============================================
-- NESA Education Data Platform
-- Task 10: Transform NESA -> _CLEAN (Flatten)
-- ============================================

USE DATABASE NESA_EDUCATION;
USE SCHEMA STAGING;

TRUNCATE TABLE IF EXISTS NESA_SOURCE_DATA_CLEAN;

INSERT INTO NESA_SOURCE_DATA_CLEAN (
    source_record_id, 
    source_file_name, 
    source_row_number, 
    raw_data, 
    loaded_at,
    staged_at,
    title, 
    description, 
    region_name, 
    subcategory_title, 
    subcategory_description, 
    nominee_name, 
    nominee_achievement, 
    nominee_country, 
    nominee_state, 
    nominee_image
)
WITH base_data AS (
    -- 1. Récupérer les champs de base (titre, description)
    SELECT
        source_record_id,
        source_file_name,
        source_row_number,
        raw_data,
        loaded_at,
        CURRENT_TIMESTAMP() AS staged_at,
        TRIM(raw_data:title::STRING) AS title,
        TRIM(raw_data:description::STRING) AS description
    FROM NESA_EDUCATION.STAGING.NESA_SOURCE_STAGING_RAW
),
flat_data AS (
    -- 2. Aplatir toutes les clés pour extraire les index (s_idx = catégorie, n_idx = nominé)
    SELECT
        t.source_record_id,
        f.key::STRING AS full_key,
        TRIM(f.value::STRING) AS val,
        REGEXP_SUBSTR(f.key::STRING, 'subCategories/([0-9]+)/', 1, 1, 'e', 1) AS s_idx,
        REGEXP_SUBSTR(f.key::STRING, 'subCategories/[0-9]+/nominees/([0-9]+)/', 1, 1, 'e', 1) AS n_idx
    FROM NESA_EDUCATION.STAGING.NESA_SOURCE_STAGING_RAW t,
    LATERAL FLATTEN(input => t.raw_data) f
    WHERE f.key::STRING LIKE 'subCategories/%'
),
subcategories AS (
    -- 3. Extraire les titres et descriptions des sous-catégories
    SELECT
        source_record_id,
        s_idx,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/title' THEN val END) AS subcategory_title,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/description' THEN val END) AS subcategory_description
    FROM flat_data
    WHERE n_idx IS NULL
    GROUP BY source_record_id, s_idx
),
nominees AS (
    -- 4. Extraire les informations des nominés
    SELECT
        source_record_id,
        s_idx,
        n_idx,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/nominees/' || n_idx || '/name' THEN val END) AS nominee_name,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/nominees/' || n_idx || '/achievement' THEN val END) AS nominee_achievement,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/nominees/' || n_idx || '/country' THEN val END) AS nominee_country,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/nominees/' || n_idx || '/state' THEN val END) AS nominee_state,
        MAX(CASE WHEN full_key = 'subCategories/' || s_idx || '/nominees/' || n_idx || '/image' THEN val END) AS nominee_image
    FROM flat_data
    WHERE n_idx IS NOT NULL
    GROUP BY source_record_id, s_idx, n_idx
)
-- 5. Assembler le tout
SELECT
    b.source_record_id,
    b.source_file_name,
    b.source_row_number,
    b.raw_data,
    b.loaded_at,
    b.staged_at,
    b.title,
    b.description,
    NULL AS region_name, -- Les données de régions sont vides dans la source
    sc.subcategory_title,
    sc.subcategory_description,
    n.nominee_name,
    n.nominee_achievement,
    n.nominee_country,
    n.nominee_state,
    n.nominee_image
FROM nominees n
JOIN base_data b ON n.source_record_id = b.source_record_id
LEFT JOIN subcategories sc ON n.source_record_id = sc.source_record_id AND n.s_idx = sc.s_idx
WHERE n.nominee_name IS NOT NULL AND n.nominee_name != '';