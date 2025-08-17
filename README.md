# dbt-retail-data
This project demonstrates an end-to-end ETL pipeline using python, dbt, and BigQuery.

## Project Overview
### Tools Used
- **Python & Pandas**: For data extraction and preprocessing.
- **dbt (Data Build Tool)**: For building staging and warehouse layers, ensuring modular, maintainable transformations
- **Google BigQuery**: Cloud-based data warehouse for storage and querying.

### Data Ingestion
- Raw retail data is ingested from **Google Sheets** using **Python** and **Pandas**.
- Data is loaded into **BigQuery** as an analysis-ready table.

### Data Transformation
- **Staging Layer:** This layer is the first step in the transformation process. It focuses on cleaning and standardizing the raw data from the ingestion step without applying business logic.   
  - `staging__retail_data.sql`The single staging model that handles initial data cleansing tasks such as:
    - Casting columns to their appropriate data types (e.g., INT64, FLOAT64, TIMESTAMP).
    - De-duplicating rows to ensure unique records. 

- **Warehouse Layer:** From the clean staging data, the warehouse layer builds a dimensional model designed for efficient querying and reporting. This **Star Schema** architecture separates transactional data (facts) from descriptive attributes (dimensions).

  **Dimension Tables:**
  - `dim__retail__customer`: Stores unique customer information, such as `customer_id` and `customer_country`.
  - `dim__retail__product_data`: Contains unique product attributes like`stock_id` and `product_description`.

  **Fact Table:**
  - `fact__retail__sales_data`: The central table containing the quantitative, measurable data points of each transaction. (`stock_id, customer_id`) that link to the dimension tables, and measures like `product_quantity`, `product_price`, and `total_amount`.

## Business Value and Key Outcomes
The structured output of this pipeline provides significant business value, including:

- Reliable Analytics: The transformed data is clean, tested, and organized, eliminating data quality issues and providing a single source of truth for reporting.

- Enhanced Reporting: The star schema design allows for fast, intuitive analysis of key business questions, such as:
  - What are our top-selling products by quantity or revenue?
  - Which countries generate the most sales?
  - What is the trend of sales over time?

- Reproducible Workflow: The use of dbt ensures that all transformations are idempotent, version-controlled, and documented, making the entire pipeline easy to maintain and scale.

## dbt Model Structure
```text
models/
├── staging_layer/
│   └── staging__retail_data.sql
└── warehouse_layer/
    ├── dim__retail__customer/
    │   ├── dim__retail__customer.sql
    │   └── dim__retail__customer.yml
    ├── dim__retail__product_data/
    │   ├── dim__retail__product_data.sql
    │   └── dim__retail__product_data.yml
    └── fact__retail__sales_data/
        ├── fact__retail__sales_data.sql
        └── fact__retail__sales_data.yml
```

