
from db_connection import get_connection


def check_programme_dependencies():

    query = """
        SELECT
            tc.table_schema,
            tc.table_name,
            kcu.column_name,
            ccu.table_schema AS referenced_schema,
            ccu.table_name AS referenced_table,
            ccu.column_name AS referenced_column,
            tc.constraint_name
        FROM information_schema.table_constraints AS tc
        JOIN information_schema.key_column_usage AS kcu
            ON tc.constraint_name = kcu.constraint_name
            AND tc.constraint_schema = kcu.constraint_schema
        JOIN information_schema.constraint_column_usage AS ccu
            ON ccu.constraint_name = tc.constraint_name
            AND ccu.constraint_schema = tc.constraint_schema
        WHERE tc.constraint_type = 'FOREIGN KEY'
          AND ccu.table_schema = 'core'
          AND ccu.table_name = 'programmes'
        ORDER BY tc.table_schema, tc.table_name;
    """

    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(query)
            results = cursor.fetchall()

    print("Programme Database Dependencies")
    print("--------------------------------")

    if not results:
        print("No foreign-key dependencies found.")
    else:
        for row in results:
            print(
                f"Table: {row[0]}.{row[1]} | "
                f"Column: {row[2]} | "
                f"Constraint: {row[6]}"
            )


if __name__ == "__main__":
    check_programme_dependencies()
