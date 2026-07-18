--Database Scoped Credential
CREATE DATABASE SCOPED CREDENTIAL yashCreds
WITH IDENTITY = 'Managed Identity'

--External Data Source 
CREATE EXTERNAL DATA SOURCE silver_source
WITH(
    LOCATION = 'https://synapsdwhlake.dfs.core.windows.net/silver/',
    CREDENTIAL = yashCreds
)

CREATE EXTERNAL DATA SOURCE gold_source
WITH(
    LOCATION = 'https://synapsdwhlake.dfs.core.windows.net/gold/',
    CREDENTIAL = yashCreds
)

--External File Format
CREATE EXTERNAL FILE FORMAT parquet_format
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)


CREATE EXTERNAL FILE FORMAT delta
WITH (
    FORMAT_TYPE = DELTA
)