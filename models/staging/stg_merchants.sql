{{ config(materialized='view') }}

with source as (

    select * from {{ source('raw', 'MERCHANT_MASTER') }}

),

renamed as (

    select
        merchant_id,
        merchant_name,
        category          as merchant_category,
        city,
        sla_target_minutes::integer as sla_target_minutes
    from source

)

select * from renamed