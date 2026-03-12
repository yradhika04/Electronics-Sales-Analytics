with products_data as (
    select *
    from {{ ref('stg_electronics_retailer__products') }}
),
final as (
    select product_key,
           product_name,
           brand,
           color,
           unit_cost_usd,
           unit_price_usd,
           unit_price_usd - unit_cost_usd as unit_profit_usd,
           subcategory_key,
           subcategory,
           category_key,
           category
    from products_data
)
select *
from final