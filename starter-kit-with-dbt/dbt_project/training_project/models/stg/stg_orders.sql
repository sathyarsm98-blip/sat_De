{{ config(materialized='table') }}
select
  cast(order_id as bigint)      as order_id,
  cast(order_ts as timestamptz) as order_ts,
  cast(customer_id as bigint)   as customer_id,
  cast(amount as numeric(12,2)) as amount,
  cast(status as text)          as status
from {{ source('raw','orders') }}
