
with get_cohort_year as (
    select customer_key,
           EXTRACT(year from MIN(order_date)) as cohort_year
    from {{ ref('fct_core__sales') }}
    group by customer_key
),
customer_data as (
    select customer_key,
           EXTRACT(year from order_date) as purchase_year,
           SUM(line_item_revenue_usd) as purchase_year_revenue,
           COUNT(distinct order_number) as purchase_year_orders
    from {{ ref('fct_core__sales') }}
    group by customer_key, EXTRACT(year from order_date)
)
select g.cohort_year,
       c.purchase_year,
       c.purchase_year - g.cohort_year as years_since_first_purchase,
       count(distinct c.customer_key) as total_customers,
       sum(c.purchase_year_revenue) as total_revenue,
       sum(c.purchase_year_orders) as total_orders
from customer_data c
join get_cohort_year g on c.customer_key = g.customer_key
group by g.cohort_year, c.purchase_year



