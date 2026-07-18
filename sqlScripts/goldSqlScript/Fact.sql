IF NOT EXISTS(SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE t.name = 'FactOrders' AND s.name = 'gold')
    CREATE EXTERNAL TABLE gold.FactOrders
    WITH (
        LOCATION = 'FactOrders',
        DATA_SOURCE = gold_source,
        FILE_FORMAT = parquet_format
    )
    AS
    SELECT 
        o.DimOrdersKey,
        c.DimCustomerKey,
        p.DimProductKey,
        g.DimGeographyKey,
        f.Quantity,
        f.UnitPrice,
        f.TotalAmount
    FROM 
        silver.silverTable f
    LEFT JOIN
        gold.DimOrders o ON f.OrderID = o.OrderID
    LEFT JOIN 
        gold.DimCustomer c ON f.CustomerID = c.CustomerID
    LEFT JOIN
        gold.DimProduct p ON f.ProductID = p.ProductID
    LEFT JOIN 
        gold.DimGeography g ON f.RegionID = g.RegionID AND f.Country = g.Country

