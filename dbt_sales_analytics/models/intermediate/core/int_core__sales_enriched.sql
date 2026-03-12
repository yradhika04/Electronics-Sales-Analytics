with sales_data as (
    select *
    from {{ ref('stg_electronics_retailer__sales') }}
),

product_data as (
    select product_key, unit_cost_usd, unit_price_usd
    from {{ ref('stg_electronics_retailer__products') }}
),

final as (
    select s.order_number,
           s.line_item,
           s.order_date,
           s.delivery_date,
           s.customer_key,
           s.store_key,
           s.product_key,
           s.quantity,
           s.currency_code,
           p.unit_cost_usd,
           p.unit_price_usd
    from sales_data s
    left join product_data p on s.product_key = p.product_key
)
select *
from final

