# To export transformed dbt marts tables as CSV files from Snowflake
# CSVs are used as the data source for Tableau Public

# This script requires a .env file with your Snowflake credentials (see .env_example)
# transformed_data output directory is not tracked in git


import snowflake.connector
import pandas as pd
import os
from dotenv import load_dotenv

load_dotenv()

connection = snowflake.connector.connect(
    user=os.getenv('SNOWFLAKE_USER'),
    password=os.getenv('SNOWFLAKE_PASSWORD'),
    account=os.getenv('SNOWFLAKE_ACCOUNT'),
    warehouse='COMPUTE_WH',
    database='AIRBYTE_ELECTRONICS_DB',
    schema='TRANSFORMED'
)

transformed_tables = [
    'fct_core__sales',
    'dim_core__customers',
    'dim_core__products',
    'dim_core__stores',
    'dim_core__dates',
    'mrt_marketing__cohort'
]

os.makedirs('../data/transformed_data', exist_ok=True)

cur = connection.cursor()

for table in transformed_tables:
    cur.execute(f'select * from {table}')
    df = cur.fetch_pandas_all()
    df.to_csv(f'../data/transformed_data/{table}.csv', index=False)

cur.close()
connection.close()