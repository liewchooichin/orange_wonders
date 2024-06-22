# Reference
# https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-python?view=azuresql
# Driver = {ODBC Driver 18 for SQL Server} with the {} included.
#
# Results:
#
# python simple_db.py
# master SQL_Latin1_General_CP1_CI_AS
# sqllcc200 SQL_Latin1_General_CP1_CI_AS
#
# It is good to use conn.close().

import os
import pyodbc
from dotenv import load_dotenv

"""
server = 'sqllcc200.database.windows.net'
database = 'sqllcc200'
username = 'sqllcc200'
password = 'BeautifulForest200' #os.getenv("SQLLCC200_PASSWORD")
driver= '{ODBC Driver 18 for SQL Server}'

connection_string = f'DRIVER={driver};SERVER=tcp:{server};PORT=1433;DATABASE={database};UID={username};PWD={password}'
"""

# Load the DB connection parameters
load_dotenv()
DB_SERVER = os.getenv("DB_SERVER")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_DRIVER = os.getenv("DB_DRIVER")

connection_string = f'DRIVER={DB_DRIVER};SERVER=tcp:{DB_SERVER};PORT=1433;DATABASE={DB_NAME};UID={DB_USER};PWD={DB_PASSWORD}'

print(f"Connection: {connection_string}")

with pyodbc.connect(connection_string) as conn:
    with conn.cursor() as cursor:
        cursor.execute("SELECT TOP 3 name, collation_name FROM sys.databases")
        row = cursor.fetchone()
        while row:
            print (str(row[0]) + " " + str(row[1]))
            row = cursor.fetchone()