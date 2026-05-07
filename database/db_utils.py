import sqlite3
import os

DB_PATH = os.path.join(os.path.dirname(__file__), 'dims.db')

def get_db_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def execute_query(query, args=(), fetchone=False, fetchall=False, commit=False):
    conn = get_db_connection()
    try:
        cur = conn.cursor()
        cur.execute(query, args)
        
        if commit:
            conn.commit()
            return cur.lastrowid
            
        if fetchone:
            return cur.fetchone()
            
        if fetchall:
            return cur.fetchall()
            
    finally:
        conn.close()
