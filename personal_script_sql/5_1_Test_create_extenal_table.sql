-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://minhstorageaccount.dfs.core.windows.net/lmman-practice-databricks/contosolake/NYCTripSmall.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]



CREATE EXTERNAL DATA SOURCE ContosoLake
WITH ( LOCATION = 'https://minhstorageaccount.dfs.core.windows.net')


SELECT 
    TOP 10 *
FROM
    OPENROWSET(
        BULK '/lmman-practice-databricks/contosolake/raw/taxi_zone.csv',
        DATA_SOURCE = 'ContosoLake',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]
    