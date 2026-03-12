with customers_data as (
    select *
    from {{ ref('stg_electronics_retailer__customers') }}
),
final as (
    select customer_key,
           gender,
           name,
           city,
           state_code,
           state,
           zip_code,
           country,
           continent,
           birthday,
           case
               -- if the current month is after the birth month
               when DATE_PART(month, current_date) > DATE_PART(month, birthday) THEN DATEDIFF('year', birthday, current_date)
               -- if the current month is before the birth month
               when DATE_PART(month, current_date) < DATE_PART(month, birthday) THEN DATEDIFF('year', birthday, current_date) - 1
               -- if the current month is same as the birth month, and current day is after or equal to the birth day
               when DATE_PART(day, current_date) >= DATE_PART(day, birthday) THEN DATEDIFF('year', birthday, current_date)
               -- if the current month is same as the birth month, and current day is before the birth day
               else DATEDIFF('year', birthday, current_date) - 1
           end as age
    from customers_data
)
select *
from final