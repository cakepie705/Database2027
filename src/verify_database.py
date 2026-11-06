import sqlite3

db_path = "data/database/nesa_education.db"

connection = sqlite3.connect(db_path)

tables = connection.execute("""
    SELECT name
    FROM sqlite_master
    WHERE type = 'table'
    ORDER BY name;
""").fetchall()

print("SQLite tables:")
for table in tables:
    print(f"- {table[0]}")

connection.close()
