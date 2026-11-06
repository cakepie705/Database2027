
from db_connection import get_connection


def preview_programme_duplicates():
    query = """
        WITH ranked_programmes AS (
            SELECT
                programme_id,
                programme_name,
                organisation_id,
                programme_status,
                start_date,
                end_date,
                created_at,
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
            programme_id,
            programme_name,
            organisation_id,
            programme_status,
            start_date,
            end_date,
            created_at,
            row_num
        FROM ranked_programmes
        ORDER BY programme_name, row_num
        LIMIT 20;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            rows = cursor.fetchall()

    print("Programme Duplicate Preview")
    print("----------------------------")

    for row in rows:
        programme_id, name, org_id, status, start, end, created, rank = row
        action = "KEEP" if rank == 1 else "REVIEW"
        print(
            f"ID={programme_id} | {name} | "
            f"Organisation={org_id} | Rank={rank} | "
            f"{action} | Created={created}"
        )


if __name__ == "__main__":
    preview_programme_duplicates()



from db_connection import get_connection


def preview_programme_duplicates():
    query = """
        WITH ranked_programmes AS (
            SELECT
                programme_id,
                programme_name,
                organisation_id,
                programme_status,
                start_date,
                end_date,
                created_at,
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
            programme_id,
            programme_name,
            organisation_id,
            programme_status,
            start_date,
            end_date,
            created_at,
            row_num
        FROM ranked_programmes
        ORDER BY programme_name, row_num
        LIMIT 20;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            rows = cursor.fetchall()

    print("NESA Programme Duplicate Preview")
    print("---------------------------------")

    for row in rows:
        programme_id, name, org_id, status, start, end, created, rank = row

        action = "KEEP" if rank == 1 else "REVIEW"

        print(
            f"ID={programme_id} | {name} | "
            f"Organisation={org_id} | Rank={rank} | "
            f"{action} | Created={created}"
        )


if __name__ == "__main__":
    preview_programme_duplicates()
