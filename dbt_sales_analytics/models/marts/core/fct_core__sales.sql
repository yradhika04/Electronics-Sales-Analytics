with sales_data as (
    select *
    from {{ ref('int_core__sales_enriched') }}
),
final as (
    select order_number,
           line_item,
           order_date,
           delivery_date,
           customer_key,
           store_key,
           product_key,
           quantity,
           currency_code,
           unit_cost_usd,
           unit_price_usd,
           unit_cost_usd * quantity as line_item_cost_usd,
           unit_price_usd * quantity as line_item_revenue_usd,
           (unit_price_usd - unit_cost_usd) * quantity as line_item_profit_usd,
           DATEDIFF('day', order_date, delivery_date) as delivery_days
    from sales_data
)
select *
from final
