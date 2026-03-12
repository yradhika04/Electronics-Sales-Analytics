
with sales_data as (

    select "ORDER NUMBER" as order_number,
           "LINE ITEM" as line_item,
           TO_DATE("ORDER DATE", 'MM/DD/YYYY') as order_date,
           TO_DATE("DELIVERY DATE", 'MM/DD/YYYY') as delivery_date,
           customerkey as customer_key,
           storekey as store_key,
           productkey as product_key,
           quantity::number as quantity,
           "CURRENCY CODE" as currency_code
    from {{ source('electronics_retailer', 'sales') }}

)
select *
from sales_data