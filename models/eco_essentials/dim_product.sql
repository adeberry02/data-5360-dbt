{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['product_ID'])}} as productkey,
product_ID,
product_type,
product_name
FROM {{ source('transactional_landing', 'product') }} 