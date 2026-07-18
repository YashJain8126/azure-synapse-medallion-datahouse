-----------------
-- DimCustomers
-----------------

IF NOT EXISTS(SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE t.name = 'DimCustomer' AND s.name = 'gold')
    CREATE EXTERNAL TABLE gold.DimCustomer
    WITH (
        LOCATION = 'DimCustomer',
        DATA_SOURCE = gold_source,
        FILE_FORMAT = parquet_format
    )
    AS 
    SELECT *, ROW_NUMBER() OVER (ORDER BY a.CustomerID) as DimCustomerKey
    FROM
    (SELECT 
        DISTINCT 
        CustomerID,
        CustomerName,
        CustomerEmail,
        Domain
    FROM 
        silver.silverTable
    ) a

-----------------
-- DimProducts
-----------------
IF NOT EXISTS(SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE t.name = 'DimProduct' AND s.name = 'gold')
    CREATE EXTERNAL TABLE gold.DimProduct
    WITH (
        LOCATION = 'DimProduct',
        DATA_SOURCE = gold_source,
        FILE_FORMAT = parquet_format
    )
    AS 
    SELECT * , ROW_NUMBER() OVER (ORDER BY b.ProductID) as DimProductKey
    FROM 
    (SELECT 
        DISTINCT 
        ProductID,
        ProductName,
        ProductCategory
    FROM silver.silverTable ) b

-----------------
-- DimGeography
-----------------
IF NOT EXISTS(SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE t.name = 'DimGeography' AND s.name = 'gold')
    CREATE EXTERNAL TABLE gold.DimGeography
    WITH (
        LOCATION = 'DimGeography',
        DATA_SOURCE = gold_source,
        FILE_FORMAT = parquet_format
    )
    AS 
    SELECT *, ROW_NUMBER() OVER (ORDER BY c.RegionID) as DimGeographyKey
    FROM 
    (SELECT 
        DISTINCT 
        RegionID,
        Country
    FROM silver.silverTable
    ) c

-----------------
-- DimOrders
-----------------
IF NOT EXISTS(SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE t.name = 'DimOrders' AND s.name = 'gold')
    CREATE EXTERNAL TABLE gold.DimOrders
    WITH (
        LOCATION = 'DimOrders',
        DATA_SOURCE = gold_source,
        FILE_FORMAT = parquet_format
    )
    AS 
    SELECT * , ROW_NUMBER() OVER (ORDER BY d.CustomerID) as DimOrdersKey
    FROM 
    (SELECT 
        OrderID,
        CustomerID,
        CustomerName,
        CustomerEmail,
        ProductID,
        ProductName,
        ProductCategory,
        RegionID,
        Country,
        Domain
    FROM silver.silverTable
    )d