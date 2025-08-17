{{ config(
   materialized='table',
   unique_key='stock_code',
   target_schema='halyusa_warehouse_data',
   target_table='dim__retail__product_data'
) }}

WITH product_data
AS (
    SELECT 
        stock_code AS stock_id,
        description AS product_description
    FROM 
        {{ ref('staging__retail_data') }}
)

SELECT
    *
FROM
    product_data