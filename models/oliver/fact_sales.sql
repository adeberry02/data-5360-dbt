{{ config(
    materialized = 'table',
    schema = 'oliver_dw_source'
) }}

SELECT
     c.customer_key,
     d.date_key,
     e.employee_key,
     p.product_key,
     s.store_key,
     orl.quantity,
     orl. unit_price,
     quantity * unit_price AS  dollars_sold
FROM {{ source('oliver_landing', 'orderline') }} orl
INNER JOIN {{ source('oliver_landing', 'orders') }} ord ON orl.OrderID = ord.OrderID
INNER JOIN {{ ref('oliver_dim_customer') }} c ON ord.CUSTOMER_ID = c.customer_id
INNER JOIN {{ ref('oliver_dim_employee') }} e ON ord.EMPLOYEE_ID = e.employee_id
INNER JOIN {{ ref('oliver_dim_store') }} s ON ord.STORE_ID = s.store_id
INNER JOIN {{ ref('oliver_dim_order') }} o ON ord.ORDER_ID = o.order_id
INNER JOIN {{ ref('oliver_dim_product') }} p ON orl.PRODUCT_ID = p.product_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON ord.ORDER_DATE = d.date_id;