{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    employee_id,
    first_name,
    last_name,
    email,
    PARSE_JSON(certification_JSON):certification_name::varchar AS certification_name,
    PARSE_JSON(certification_JSON):certification_cost::int AS certification_cost,
    PARSE_JSON(certification_JSON):certification_awarded_date::Date AS certification_awarded_date
from {{ source('oliver_landing', 'employee_certifications')}}