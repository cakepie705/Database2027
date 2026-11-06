import sqlite3
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent

DATABASE_PATH = PROJECT_ROOT / "data" / "database" / "nesa_education.db"
SQL_PATH = PROJECT_ROOT / "sql" / "setup" / "03_insert_nesa_regions.sql"

connection = sqlite3.connect(DATABASE_PATH)

try:
    connection.execute("PRAGMA foreign_keys = ON;")

    sql_script = SQL_PATH.read_text(encoding="utf-8")
    connection.executescript(sql_script)

    connection.commit()

    print("NESA regions loaded successfully.")

finally:
    connection.close()
