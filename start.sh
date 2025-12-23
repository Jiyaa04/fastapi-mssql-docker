#!/bin/bash

echo "Starting SQL Server..."
/opt/mssql/bin/sqlservr &

echo "Waiting for SQL Server to start..."
sleep 25

echo "Running init.sql..."
/opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P "MyComplexPass123!" \
  -i /app/init.sql

echo "Starting FastAPI..."
uvicorn main:app --host 0.0.0.0 --port 8000
