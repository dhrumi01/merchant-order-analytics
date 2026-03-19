{{ config(materialized='table') }}

with orders as (

    select * from {{ ref('stg_orders') }}

),

merchants as (

    select * from {{ ref('stg_merchants') }}

),

joined as (

    select
        o.order_id,
        o.merchant_id,
        o.merchant_name,
        o.merchant_category,
        o.city,
        o.order_timestamp,
        o.order_date,
        o.order_hour,
        o.order_month,
        o.order_status,
        o.order_value_usd,
        o.sla_target_minutes,
        o.actual_delivery_minutes,
        o.sla_breached,
        o.sla_variance_minutes,
        o.tablet_age_years,
        o.customer_id,
        o.driver_id,

        case
            when o.sla_breached = true then 'breached'
            else 'on_time'
        end as sla_status,

        case
            when o.sla_variance_minutes <= -10 then 'early'
            when o.sla_variance_minutes <= 0   then 'on_time'
            when o.sla_variance_minutes <= 10  then 'slightly_late'
            else 'significantly_late'
        end as delivery_bucket,

        case
            when o.tablet_age_years >= 4 then 'high_risk'
            when o.tablet_age_years >= 2 then 'medium_risk'
            else 'low_risk'
        end as tablet_risk

    from orders o
    left join merchants m on o.merchant_id = m.merchant_id
    where o.order_status = 'delivered'

)

select * from joined