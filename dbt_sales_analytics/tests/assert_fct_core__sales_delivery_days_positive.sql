-- Test for fct_core__sales marts models
-- Delivery_days should never be negative for delivered orders
-- So this returns records where delivery days < 0

select order_number, line_item
from {{ ref('fct_core__sales') }}
where delivery_days < 0