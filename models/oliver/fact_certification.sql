{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    e.employee_key,
    d.date_key,
    c.certification_cost,
    c.certification_name
from {{ ref('stg_employee_certifications') }} c
inner join {{ ref('oliver_dim_employee') }} e
    on c.first_name = e.firstname
    and c.last_name = e.lastname
inner join {{ ref('oliver_dim_date') }} d
    on d.date_key = c.certification_awarded_date
