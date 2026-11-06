import sqlite3

db_path = "data/database/nesa_education.db"

connection = sqlite3.connect(db_path)

connection.execute("DROP TABLE IF EXISTS evidence;")

connection.execute("""
CREATE TABLE evidence (
    evidence_id INTEGER PRIMARY KEY,
    programme_id INTEGER NOT NULL,
    source_id INTEGER NOT NULL,
    evidence_grade TEXT NOT NULL,
    actual_or_target TEXT,
    evidence_description TEXT,
    verification_status TEXT,

    FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id),

    FOREIGN KEY (source_id)
        REFERENCES sources(source_id),

    CHECK (evidence_grade IN ('A', 'B', 'C')),

    CHECK (
        actual_or_target IS NULL
        OR actual_or_target IN ('actual', 'target')
    )
);
""")

connection.commit()
connection.close()

print("Evidence table fixed successfully.")
