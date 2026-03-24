{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
     t.timekey,
     d.datekey,
     e.eventkey,
     em.emailkey,
     cu.custkey,
     ca.campaignkey
   
FROM {{ source('emailevents_landing', 'marketingemails') }} me
INNER JOIN {{ ref('ecoessentials_dim_customer') }} cu ON me.subscriberid = cu.subscriberid
INNER JOIN {{ ref('dim_event')}} e ON me.emaileventid = e.emaileventid
INNER JOIN {{ ref('dim_email')}} em ON me.emailid = em.emailid
INNER JOIN {{ ref('dim_campaign')}} ca ON me.campaignid = ca.campaign_id
INNER JOIN {{ ref('ecoessentials_dim_date')}} d ON d.FullDate = cast(me.eventtimestamp as date)
INNER JOIN {{ ref('dim_time')}} t ON t.timestamp = cast(me.eventtimestamp as time)