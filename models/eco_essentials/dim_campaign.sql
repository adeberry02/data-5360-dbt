{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['campaign_ID'])}} as campaignkey,
campaign_ID,
campaignName,
Campaign_Discount
FROM {{ source('emailevents_landing', 'marketingemails') }} me JOIN
{{ source('transactional_landing', 'promotional_campaign') }} t
ON me.campaignID = t.campaign_ID