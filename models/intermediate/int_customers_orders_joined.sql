with customers as (

    select * from {{ ref('stg_tpch__customers') }}

),

orders as (

    select * from {{ ref('stg_tpch__orders') }}

),

order_summary as (

    select
        customer_id,
        count(order_id)        as number_of_orders,
        sum(total_price)       as total_spent,
        max(order_date)        as most_recent_order_date

    from orders
    group by customer_id

),

joined as (

    select
        customers.customer_id,
        customers.customer_name,
        customers.market_segment,
        customers.account_balance,
        coalesce(order_summary.number_of_orders, 0) as number_of_orders,
        coalesce(order_summary.total_spent, 0)      as total_spent,
        order_summary.most_recent_order_date

    from customers
    left join order_summary
        on customers.customer_id = order_summary.customer_id

)

select * from joined