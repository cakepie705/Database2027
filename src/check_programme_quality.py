
from db_connection import get_connection


def check_programme_quality():
    """Check programme data quality in the NESA database."""

    query = """
        SELECT
            COUNT(*) AS total_programmes,
            COUNT(*) FILTER (
                WHERE programme_name IS NULL
                   OR TRIM(programme_name) = ''
            ) AS missing_names,
            COUNT(*) FILTER (
                WHERE programme_status IS NULL
                   OR TRIM(programme_status) = ''
            ) AS missing_statuses,
            COUNT(*) FILTER (
                WHERE start_date IS NOT NULL
                  AND end_date IS NOT NULL
                  AND end_date < start_date
            ) AS invalid_date_ranges
        FROM core.programmes;
    """

    duplicate_query = """
        SELECT
            COUNT(*) AS duplicate_groups,
            COALESCE(SUM(duplicate_count - 1), 0)
                AS duplicate_records
        FROM (
            SELECT COUNT(*) AS duplicate_count
            FROM core.programmes
            GROUP BY
                programme_name,
                organisation_id,
                programme_status,
                start_date,
                end_date
            HAVING COUNT(*) > 1
        ) AS duplicates;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchone()

            cursor.execute(duplicate_query)
            duplicate_result = cursor.fetchone()

    print("NESA Programme Data Quality Report")
    print("----------------------------------")
    print(f"Total programmes: {result[0]}")
    print(f"Missing programme names: {result[1]}")
    print(f"Missing programme statuses: {result[2]}")
    print(f"Invalid date ranges: {result[3]}")
    print(f"Duplicate groups: {duplicate_result[0]}")
    print(f"Duplicate records: {duplicate_result[1]}")


if __name__ == "__main__":
    check_programme_quality()
