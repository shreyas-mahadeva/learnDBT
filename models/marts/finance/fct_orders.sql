with transactions as (
    select * 
    from {{ ref('stg_stripe_payment') }}
), 

orders as (
    select *
    from {{ ref('stg_jaffle_shop_orders') }}
)

select orders.customer_id, transactions.orderid, sum(transactions.amount) as lifetime_value
from transactions, orders
where transactions.orderid = orders.order_id
group by orders.customer_id, transactions.orderid