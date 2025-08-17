{{ config(
   materialized='table',
   unique_key='invoice_no, stock_code',
   target_schema='halyusa_warehouse_data',
   target_table='fact__retail__sales_data'
) }}

WITH invoice_data 
AS (
    SELECT
        invoice_no AS invoice_id,
        stock_code AS stock_id,

        CASE WHEN 
            customer_id = '' THEN 'unknown' 
            ELSE customer_id
        END AS customer_id,
        
        invoice_date AS invoice_datetime,
        quantity AS product_quantity,

        CASE WHEN 
            quantity < 0 THEN 1
            ELSE 0
        END AS is_return,

        unit_price AS product_price,
        SAFE_CAST(unit_price * quantity AS FLOAT64) AS total_amount

    FROM
        {{ ref('staging__retail_data') }}
)

SELECT 
    *
FROM 
    invoice_data
