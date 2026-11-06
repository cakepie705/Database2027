import csv
import json
from pathlib import Path

import snowflake.connector
from dotenv import load_dotenv
from openpyxl import load_workbook
import os


PROJECT_ROOT = Path(__file__).resolve().parent.parent

CSV_PATH = PROJECT_ROOT / "data" / "raw" / "nesa_source_data.csv"
EXCEL_PATH = PROJECT_ROOT / "data" / "raw" / "nesa_africa_icon_nominee_register.xlsx"


load_dotenv(PROJECT_ROOT / ".env")


def connect_snowflake():
    return snowflake.connector.connect(
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database="NESA_EDUCATION",
        schema="RAW",
        role=os.getenv("SNOWFLAKE_ROLE"),
    )


def load_nesa_csv(cursor):
    rows = []

    with CSV_PATH.open("r", encoding="utf-8-sig", newline="") as file:
        reader = csv.DictReader(file)

        for row_number, row in enumerate(reader, start=2):
            rows.append(
                (
                    CSV_PATH.name,
                    row_number,
                    json.dumps(row, ensure_ascii=False),
                )
            )

    sql = """
        INSERT INTO NESA_EDUCATION.RAW.NESA_SOURCE_DATA
        (
            source_file_name,
            source_row_number,
            raw_data
        )
        SELECT
            %s,
            %s,
            PARSE_JSON(%s)
    """

    for row in rows:
        cursor.execute(sql, row)

    print(f"NESA CSV records loaded: {len(rows)}")


def load_icon_register(cursor):
    workbook = load_workbook(
        EXCEL_PATH,
        read_only=True,
        data_only=True,
    )

    worksheet = workbook["Final Refactored Register"]

    headers = [
        cell.value
        for cell in next(
            worksheet.iter_rows(
                min_row=1,
                max_row=1,
            )
        )
    ]

    rows = []

    for row_number, values in enumerate(
        worksheet.iter_rows(
            min_row=2,
            values_only=True,
        ),
        start=2,
    ):
        record = dict(zip(headers, values))

        rows.append(
            (
                EXCEL_PATH.name,
                row_number,
                json.dumps(
                    record,
                    ensure_ascii=False,
                    default=str,
                ),
            )
        )

    workbook.close()

    sql = """
        INSERT INTO NESA_EDUCATION.RAW.CSR_EDUCATION_DATA
        (
            source_file_name,
            source_row_number,
            raw_data
        )
        SELECT
            %s,
            %s,
            PARSE_JSON(%s)
    """

    for row in rows:
        cursor.execute(sql, row)

    print(f"Icon register records loaded: {len(rows)}")


def main():
    print("Starting Snowflake RAW ingestion...")

    connection = connect_snowflake()
    cursor = connection.cursor()

    try:
        load_nesa_csv(cursor)
        load_icon_register(cursor)

        connection.commit()

        print("RAW ingestion completed successfully.")

    except Exception:
        connection.rollback()
        raise

    finally:
        cursor.close()
        connection.close()


if __name__ == "__main__":
    main()
