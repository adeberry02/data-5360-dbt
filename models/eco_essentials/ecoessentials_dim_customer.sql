{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


SELECT
{{ dbt_utils.generate_surrogate_key(['customer_id', 'Customer_First_Name', 'Customer_Last_Name']) }} as custkey,
customer_id,
Customer_First_Name,
Customer_Last_Name,
Customer_Phone,
Customer_Address,
Customer_City,
Customer_State,
Customer_Zip,
Customer_Country,
Customer_Email,
SubscriberID
FROM {{ source('emailevents_landing', 'marketingemails') }} me
JOIN {{source('transactional_landing', 'customer')}} t
ON me.subscriberfirstname = t.Customer_First_Name AND me.subscriberlastname = t.Customer_Last_Name