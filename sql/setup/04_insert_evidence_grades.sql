-- NESA-Africa Data Platform
-- Evidence Grade Reference Data

-- Grade A:
-- Strong primary evidence with measurable results or outcomes.

-- Grade B:
-- Strong primary evidence with implementation or outputs,
-- but limited independently measured outcomes.

-- Grade C:
-- Further verification required.

-- Evidence grades are currently represented directly in evidence records.
-- This file documents the controlled values used by the project.

SELECT 'A' AS evidence_grade
UNION ALL
SELECT 'B'
UNION ALL
SELECT 'C';