
from db_connection import get_connection


def preview_programme_cleanup():

    query = """
        WITH ranked_programmes AS (
            SELECT
                programme_id,
                programme_name,
                organisation_id,
                programme_status,
                start_date,
                end_date,
                ROW_NUMBER() OVER (
                    PARTITION BY
                        programme_name,
                        organisation_id,
                        programme_status,
                        start_date,
                        end_date
                    ORDER BY programme_id ASC
                ) AS row_num
            FROM core.programmes
        )
        SELECT
            COUNT(*) AS total_records,
            COUNT(*) FILTER (
                WHERE row_num = 1
            ) AS records_to_keep,
            COUNT(*) FILTER (
                WHERE row_num > 1
            ) AS records_to_review
        FROM ranked_programmes;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchone()

    print("NESA Programme Cleanup Preview")
    print("--------------------------------")
    print(f"Total records: {result[0]}")
    print(f"Records to keep: {result[1]}")
    print(f"Records to review: {result[2]}")

    if result[1] + result[2] == result[0]:
        print("Cleanup preview: PASSED")
    else:
        print("Cleanup preview: FAILED")


if __name__ == "__main__":
    preview_programme_cleanup()
