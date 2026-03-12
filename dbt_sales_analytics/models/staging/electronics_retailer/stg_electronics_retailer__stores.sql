
with stores_data as (

    select storekey as store_key,
           country,
           state,
           "SQUARE METERS"::numeric AS square_meters,
           TO_DATE("OPEN DATE", 'MM/DD/YYYY') as open_date
    from {{ source('electronics_retailer', 'stores') }}

)
select *
from stores_data