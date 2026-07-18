-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'enrichedSales',
        DATA_SOURCE = 'silver_source',
        FORMAT = 'PARQUET'
    ) AS [result]

SELECT * FROM silver.silverTable


SELECT * FROM 
OPENROWSET
(
    BULK 'enrichedSales',
    DATA_SOURCE = 'silver_source',
    FORMAT = 'PARQUET'
) 
WITH
(
    ORDER_ID VARCHAR(100) 1
)as q3