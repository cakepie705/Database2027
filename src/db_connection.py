
import os

import psycopg
from dotenv import load_dotenv

# Load database settings from the project .env file.
load_dotenv()

def get_connection():
    """Connect Python to the NESA PostgreSQL database."""
    return psycopg.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("POSTGRES_DB", "nesa_data"),
        user=os.getenv("POSTGRES_USER", "nesa_admin"),
        password=os.getenv("POSTGRES_PASSWORD"),
        connect_timeout=10,
    )


if __name__ == "__main__":
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT current_database(), current_user;")
                database, user = cursor.fetchone()

                print("PostgreSQL connection successful!")
                print(f"Database: {database}")
                print(f"User: {user}")

    except Exception as error:
        print(f"Database connection failed: {error}")
        raise
