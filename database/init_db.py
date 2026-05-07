import sqlite3
import os

def init_db():
    """
    Initializes the database using the schema.sql file.
    """
    # Define paths
    current_dir = os.path.dirname(__file__)
    schema_path = os.path.join(current_dir, '..', 'schema.sql')
    db_path = os.path.join(current_dir, 'dims.db')
    
    # Read the schema file
    if not os.path.exists(schema_path):
        print(f"Error: Schema file not found at {schema_path}")
        return

    with open(schema_path, 'r', encoding='utf-8') as f:
        schema_sql = f.read()

    # Connect and execute the schema
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.executescript(schema_sql)
        conn.commit()
        conn.close()
        print("Database initialized successfully with sample data.")
    except sqlite3.Error as e:
        print(f"An error occurred while initializing the database: {e}")

if __name__ == "__main__":
    init_db()
