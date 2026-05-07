import sqlite3
import os

def init_db():
    current_dir = os.path.dirname(__file__)
    db_path = os.path.join(current_dir, 'dims.db')
    schema_path = os.path.join(current_dir, 'schema.sql')
    
    # Check if schema file exists
    if not os.path.exists(schema_path):
        # Fallback to root dir if schema.sql is not in database directory
        schema_path = os.path.join(os.path.dirname(current_dir), 'schema.sql')

    print(f"Initializing database at {db_path} using schema {schema_path}")
    
    conn = sqlite3.connect(db_path)
    try:
        with open(schema_path, 'r', encoding='utf-8') as f:
            sql_script = f.read()
        
        conn.executescript(sql_script)
        conn.commit()
        print("Database initialized successfully with seed data.")
    except Exception as e:
        print(f"An error occurred while initializing database: {e}")
    finally:
        conn.close()

if __name__ == '__main__':
    init_db()
