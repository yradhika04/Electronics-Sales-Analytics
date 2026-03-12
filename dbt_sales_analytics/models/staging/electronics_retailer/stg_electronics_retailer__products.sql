
with products_data as (

    select productkey as product_key,
           "PRODUCT NAME" as product_name,
           brand,
           color,
           TO_DECIMAL(REPLACE(REPLACE("UNIT COST USD", '$', ''), ',', ''), 10, 2) as unit_cost_usd,
           TO_DECIMAL(REPLACE(REPLACE("UNIT PRICE USD", '$', ''), ',', ''), 10, 2) as unit_price_usd,
           subcategorykey as subcategory_key,
           subcategory,
           categorykey as category_key,
           category
    from {{ source('electronics_retailer', 'products') }}

)
select *
from products_data
