{{ config(
   materialized='table',
   unique_key='customer_id',
   target_schema='halyusa_warehouse_data',
   target_table='dim__retail__customer_data'
) }}

WITH customer_data
AS (
    SELECT 
        customer_id AS customer_id,
        country AS customer_country
    FROM 
        {{ ref('staging__retail_data') }}
)

SELECT
    *
FROM
    customer_data