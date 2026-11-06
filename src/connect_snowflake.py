import os

import snowflake.connector
from dotenv import load_dotenv


# Load environment variables from .env
load_dotenv()


# Connect to Snowflake
connection = snowflake.connector.connect(
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database=os.getenv("SNOWFLAKE_DATABASE"),
    schema=os.getenv("SNOWFLAKE_SCHEMA"),
    role=os.getenv("SNOWFLAKE_ROLE"),
)


print("Snowflake connection successful!")


# Test the connection
cursor = connection.cursor()

try:
    cursor.execute("SELECT CURRENT_VERSION()")
    version = cursor.fetchone()[0]

    print(f"Snowflake version: {version}")

finally:
    cursor.close()
    connection.close()