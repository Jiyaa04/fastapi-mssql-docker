from fastapi import FastAPI, HTTPException
import pyodbc
import time
import sys

app = FastAPI()

# CHANGE 1: Switched to Driver 17 (Most common in Docker)
# CHANGE 2: Added Encrypt=yes and TrustServerCertificate=yes for safety
CONN_STR = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=127.0.0.1;"
    "DATABASE=DemoDB;"
    "UID=sa;"
    "PWD=MyComplexPass123!;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
)

def get_connection(retries=15, delay=2):
    print(f"🔌 Connecting to: {CONN_STR.replace('Docker@@2004', '******')}") # Log config (hiding password)
    
    for i in range(retries):
        try:
            conn = pyodbc.connect(CONN_STR, timeout=5)
            print("✅ successfully connected to SQL Server!")
            return conn
        except Exception as e:
            # CHANGE 3: actually printing the error!
            print(f"⚠️ Attempt {i+1} failed: {e}")
            time.sleep(delay)
            
    print("❌ Fatal: Could not connect to SQL Server after multiple attempts.")
    raise Exception("SQL Server not ready after retries")

@app.get("/tables")
def list_tables():
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_TYPE = 'BASE TABLE'
        """)

        tables = [row[0] for row in cursor.fetchall()]
        conn.close()
        return {"tables": tables}
    except Exception as e:
        print(f"🔥 Error in /tables endpoint: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    



#to build: docker build -t fastapi-mssql .
#to run: docker run -p 9000:8000 fastapi-mssql
#if any port is busy docker rm -f $(docker ps -aq)
#http://localhost:9000/tables