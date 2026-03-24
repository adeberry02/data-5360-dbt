{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
     o.customer_id,
     o.order_id,
     pr.productkey,
     d.datekey,
     c.custkey,
     ca.campaignkey,
     p.price,
     ord.quantity,
     ord.discount,
     ord.Price_After_Discount

     
FROM adelaideberry.TRANSACTIONAL_DW_SOURCE_ECOESSENTIALS_TRANSACTIONAL_DB."ORDER" o
INNER JOIN {{ source('transactional_landing', 'order_line') }} ord ON o.order_id = ord.order_id
INNER JOIN {{ source('transactional_landing', 'product')}} p ON ord.product_id = p.product_id
INNER JOIN {{ ref('ecoessentials_dim_customer') }} c ON o.customer_id = c.customer_id
INNER JOIN {{ ref('dim_campaign')}} ca ON ord.campaign_id = ca.campaign_id
INNER JOIN {{ ref('dim_product')}} pr ON ord.product_id = pr.product_id
INNER JOIN {{ ref('ecoessentials_dim_date')}} d ON d.FullDate = cast(o.order_timestamp as date)
