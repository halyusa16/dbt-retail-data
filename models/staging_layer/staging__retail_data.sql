{{ config(
   materialized='table',
   unique_key='invoice_no, stock_code',
   target_schema='halyusa_staging_data',
   target_table='staging__retail_data'
) }}

WITH raw_data AS (
    SELECT
        SAFE_CAST(InvoiceNo AS STRING) AS invoice_no,
        SAFE_CAST(StockCode AS STRING) AS stock_code,
        SAFE_CAST(Description AS STRING) AS description,
        SAFE_CAST(Quantity AS INT64) AS quantity,
        SAFE_CAST(InvoiceDate AS TIMESTAMP) AS invoice_date,
        SAFE_CAST(UnitPrice AS FLOAT64) AS unit_price,
        SAFE_CAST(CustomerID AS STRING) AS customer_id,
        SAFE_CAST(Country AS STRING) AS country
    FROM
        {{ source('halyusa_data', 'online_retail_data') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY invoice_no, stock_code ORDER BY invoice_date DESC) = 1
)

SELECT 
    * 
FROM 
    raw_data