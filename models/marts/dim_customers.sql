with hub as (
    select * from {{ ref('hub_customer') }}
),

sat as (
    select * from {{ ref('sat_customer') }}
    qualify row_number() over (partition by customer_hk order by load_datetime desc) = 1
),

link as (
    select * from {{ ref('link_customer_order') }}
),

sat_order as (
    select * from {{ ref('sat_order') }}
    qualify row_number() over (partition by order_hk order by load_datetime desc) = 1
),

order_summary as (
    select
        link.customer_hk,
        count(sat_order.order_hk)      as number_of_orders,
        sum(sat_order.total_price)     as total_spent,
        max(sat_order.order_date)      as most_recent_order_date

    from link
    inner join sat_order on link.order_hk = sat_order.order_hk
    group by link.customer_hk
),

final as (
    select
        hub.customer_id,
        sat.customer_name,
        sat.market_segment,
        sat.account_balance,
        coalesce(order_summary.number_of_orders, 0) as number_of_orders,
        coalesce(order_summary.total_spent, 0)      as total_spent,
        order_summary.most_recent_order_date,

        case
            when coalesce(order_summary.number_of_orders, 0) = 0 then 'Jamais commandé'
            when order_summary.number_of_orders < 5 then 'Client occasionnel'
            else 'Client régulier'
        end as customer_segment

    from hub
    left join sat on hub.customer_hk = sat.customer_hk
    left join order_summary on hub.customer_hk = order_summary.customer_hk
)

select * from final