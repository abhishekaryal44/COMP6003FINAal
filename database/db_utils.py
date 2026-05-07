import sqlite3
import os

DATABASE = os.path.join(os.path.dirname(__file__), 'dims.db')

def get_db_connection():
    """
    Establishes a connection to the SQLite database.
    Returns the connection object with Row factory enabled.
    """
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def execute_query(query, params=(), fetchone=False, fetchall=False):
    """
    Utility function to execute a query and return results.
    """
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    
    result = None
    if fetchone:
        result = cursor.fetchone()
    elif fetchall:
        result = cursor.fetchall()
    
    conn.commit()
    conn.close()
    return result
