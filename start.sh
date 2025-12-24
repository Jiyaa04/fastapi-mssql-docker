#!/bin/bash

echo "Starting SQL Server..."
/opt/mssql/bin/sqlservr &

# Robust wait loop: Try connecting every second until successful
echo "Waiting for SQL Server to be ready..."
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "MyComplexPass123!" -Q "SELECT 1" &> /dev/null
do
  echo "Server not ready yet, retrying in 2 seconds..."
  sleep 2
done

echo "SQL Server is UP! Running init.sql..."
/opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P "MyComplexPass123!" \
  -i /app/init.sql

echo "Database initialized. Starting FastAPI..."
uvicorn main:app --host 0.0.0.0 --port 8000