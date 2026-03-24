{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['emaileventid'])}} as eventkey,
emaileventid,
eventtype
FROM {{ source('emailevents_landing', 'marketingemails') }}