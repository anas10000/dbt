with hub as (
    select * from {{ ref('hub_customer') }}
),

sat as (
    select * from {{ ref('sat_customer') }}
    qualify row_number() over (partition by customer_hk order by load_datetime desc) = 1
),

final as (
    select
        hub.customer_id,
        sat.customer_name,
        sat.market_segment,
        sat.account_balance

    from hub
    left join sat on hub.customer_hk = sat.customer_hk
)

select * from final