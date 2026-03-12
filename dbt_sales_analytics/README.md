# Electronics Sales & Customer Analytics (dbt)

### Overview
This dbt project follows a layered structure: **staging -> intermediate -> marts** 
and transforms raw sales data for a global electronics retailer 
into analytical tables used for Tableau dashboards.


### Project Structure
```
models/
  staging/          # 1:1 with source tables, cleaning and renaming
  intermediate/     # Joins between staging models
  marts/
    core/           # Marts (facts and dims following a star schema) that aren't domain specific
    marketing/      # Marts for marketing analysis
tests/              # Custom singular tests
```

### Tests
- **Generic tests** - not_null and unique tests on all primary keys across all models
- **Singular tests** - `assert_fct_core__sales_delivery_days_positive` ensures delivery days are never negative


### Setup Instructions
This project assumes the raw data already exists in Snowflake. 
The data was originally ingested into Snowflake from Google Sheets using Airbyte.

1. Download the dataset from [Maven Analytics](https://mavenanalytics.io/data-playground/global-electronics-retailer)
2. Create a Snowflake account and load the data
3. Clone the repository
```
https://github.com/yradhika04/Electronics-Sales-Analytics.git
```
```
cd Electronics-Sales-Analytics
```
4. Set up a Python virtual environment 
``` 
python3 -m venv venv 
```
```
source venv/bin/activate
```

5. Install requirements
```
pip install -r requirements.txt
```

6. Make a `.env` configuration file with your Snowflake credentials following `.env.example`


7. Create a profiles.yml file with your Snowflake credentials 
``` 
mkdir -p ~/.dbt
```
```
nano ~/.dbt/profiles.yml
```
The content of the profiles.yml file, replace the values of the parameter with your own credentials: 
```
dbt_sales_analytics:
  outputs:
    dev:
      type: snowflake
      threads: 4
      account: <your_snowflake_account_details>
      database: <snowflake_database_name>
      user: <login-name>
      password: <yourpassword>
      schema: <your_snowflake_schema_name>
      warehouse: <compute_wh>
      role: <snowflake_role>
  target: dev
```

8. Navigate to the dbt project folder
```
cd dbt_sales_analytics
```

9. Check connection with Snowflake
```
dbt debug
```

10. Install dbt dependencies
```
dbt deps
```

11. Run models

```
dbt run
```
12. Run tests

```
dbt test
```