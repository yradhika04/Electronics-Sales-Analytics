
with exchange_rates_data as (

    select TO_DATE("DATE", 'MM/DD/YYYY') as exchange_rate_date,
           currency,
           TO_DECIMAL(exchange, 10, 4) as exchange_rate
    from {{ source('electronics_retailer', 'exchange_rates') }}

)
select *
from exchange_rates_data