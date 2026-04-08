{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

with sales_source as (
    select
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
    from {{ source('transactional_landing', 'customer') }}
)

, marketing_emails_source as (
    select distinct
        SubscriberID,
        subscriberfirstname,
        subscriberlastname,
        subscriberemail
    from {{ source('emailevents_landing', 'marketingemails') }}
)

, final as (
    select
        ss.customer_id,
        coalesce(ss.Customer_First_Name, mes.subscriberfirstname) as firstname,
        coalesce(ss.Customer_Last_Name, mes.subscriberlastname) as lastname,
        Customer_Phone,
        Customer_Address,
        Customer_City,
        Customer_State,
        Customer_Zip,
        Customer_Country,
        coalesce(ss.customer_email, mes.subscriberemail) as email,
        mes.SubscriberID
    from sales_source ss
    full join marketing_emails_source mes
        on ss.Customer_First_Name = mes.subscriberfirstname
        and ss.Customer_Last_Name = mes.subscriberlastname
)

select
    {{ dbt_utils.generate_surrogate_key(['firstname', 'lastname']) }} as custkey,
    *
from final