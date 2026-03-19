{{ config(materialized='view') }}

with source as (

    select * from {{ source('raw', 'ORDERS_RAW') }}

),

renamed as (

    select
        order_id,
        merchant_id,
        merchant_name,
        merchant_category,
        city,
        order_timestamp::timestamp     as order_timestamp,
        order_date::date               as order_date,
        order_hour::integer            as order_hour,
        order_month::integer           as order_month,
        order_status,
        order_value_usd::float         as order_value_usd,
        sla_target_minutes::integer    as sla_target_minutes,
        actual_delivery_minutes::float as actual_delivery_minutes,
        sla_breached::boolean          as sla_breached,
        sla_variance_minutes::float    as sla_variance_minutes,
        tablet_age_years::integer      as tablet_age_years,
        customer_id,
        driver_id
    from source

)

select * from renamed