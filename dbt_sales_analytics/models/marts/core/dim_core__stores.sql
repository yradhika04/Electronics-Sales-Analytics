with stores_data as (
    select *
    from {{ ref('stg_electronics_retailer__stores') }}
),
final as (
    select store_key,
           country,
           state,
           square_meters,
           open_date,
           case
               -- if the current month is after the open_date month
               when DATE_PART(month, current_date) > DATE_PART(month, open_date) THEN DATEDIFF('year', open_date, current_date)
               -- if the current month is before the open_date month
               when DATE_PART(month, current_date) < DATE_PART(month, open_date) THEN DATEDIFF('year', open_date, current_date) - 1
               -- if the current month is same as the open_date month, and current day is after or equal to the open_date day
               when DATE_PART(day, current_date) >= DATE_PART(day, open_date) THEN DATEDIFF('year', open_date, current_date)
               -- if the current month is same as the open_date month, and current day is before the open_date day
               else DATEDIFF('year', open_date, current_date) - 1
           end as store_age
    from stores_data
)
select *
from final