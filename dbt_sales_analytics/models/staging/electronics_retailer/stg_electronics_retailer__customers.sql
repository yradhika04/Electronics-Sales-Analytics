
with customers_data as (

    select customerkey as customer_key,
           gender,
           name,
           city,
           "STATE CODE" as state_code,
           state,
           "ZIP CODE" as zip_code,
           country,
           continent,
           TO_DATE(birthday, 'MM/DD/YYYY') as birthday
    from {{ source('electronics_retailer', 'customers') }}

)
select *
from customers_data
