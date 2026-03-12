with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2005-03-01' as date)",
        end_date="cast('2021-03-01' as date)"
    ) }}
)
select
    date_day as date_key,
    extract(year from date_day) as year_num,
    extract(quarter from date_day) as quarter,
    extract(month from date_day) as month_num,
    monthname(date_day) as month_name,
    extract(week_iso from date_day) as week_iso,
    extract(dayofweekiso from date_day) as day_of_week_iso, -- monday is 1 and sunday is 7
    extract(day from date_day) as day_num,
    dayname(date_day) as day_name,
    case
        when dayname(date_day) in ('Sat','Sun') then true
        else false
    end as is_weekend
from date_spine