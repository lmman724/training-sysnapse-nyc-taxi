USE nyc_taxi_ldw

--create silver.taxi_zone

IF OBJECT_ID('silver.taxi_zone') IS NOT NULL
    DROP EXTERNAL TABLE silver.taxi_zone;
GO

CREATE EXTERNAL TABLE silver.taxi_zone
    WITH(
        DATA_SOURCE = ContosoLake,
        LOCATION = '/lmman-practice-databricks/contosolake/silver/taxi_zone',
        FILE_FORMAT = parquet_file_format

    )
AS
SELECT * FROM bronze.taxi_zone;

SELECT * FROM silver.taxi_zone;

--create silver.calendar

-- IF OBJECT_ID(silver.calendar) IS NOT NULL
--     DROP EXTERNAL TABLE silver.calendar;

CREATE EXTERNAL TABLE silver.calendar
    WITH(
        DATA_SOURCE = ContosoLake,
        LOCATION = '/lmman-practice-databricks/contosolake/silver/calendar',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT * FROM bronze.calendar;

SELECT * FROM silver.calendar;

-- create silver.trip_type

IF OBJECT_ID('silver.trip_type') IS NOT NULL
    DROP EXTERNAL TABLE silver.trip_type;

CREATE EXTERNAL TABLE silver.trip_type
    WITH
    (
        DATA_SOURCE = ContosoLake,
        LOCATION = '/lmman-practice-databricks/contosolake/silver/trip_type',
        FILE_FORMAT = parquet_file_format
    )
AS SELECT * FROM bronze.trip_type

SELECT * FROM silver.trip_type

-- create usp_silver_payment_type

CREATE OR ALTER PROCEDURE silver.usp_silver_payment_type
AS
BEGIN 

    IF OBJECT_ID('silver.payment_type') IS NOT NULL
        DROP EXTERNAL TABLE silver.payment_type;
    
    CREATE EXTERNAL TABLE silver.payment_type
    WITH(
        DATA_SOURCE = ContosoLake,
        LOCATION = '/lmman-practice-databricks/contosolake/silver/payment_type',
        FILE_FORMAT = parquet_file_format
    )
    AS
    SELECT payment_type, description
    FROM OPENROWSET(
        BULK '/lmman-practice-databricks/contosolake/raw/payment_type.json'
        DATA_SOURCE = 'ContosoLake',
        FILE_FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b'
    )
        WITH
    (
        jsonDoc NVARCHAR(MAX)
    ) AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type SMALLINT,
        description VARCHAR(20) '$.payment_type_desc'
    );


END;

--create silver.vendor

-- IF OBJECT_ID(silver.vendor) IS NOT NULL
--     DROP EXTERNAL TABLE silver.vendor;

-- CREATE EXTERNAL TABLE silver.vendor
--     WITH(
--         DATA_SOURCE = ContosoLake,
--         LOCATION = '/lmman-practice-databricks/contosolake/silver/vendor',
--         FILE_FORMAT = parquet_file_format
--     )

-- AS SELECT * FROM bronze.vendor;

-- SELECT * FROM silver.vendor;


--create 


IF OBJECT_ID(silver.rate_code) IS NOT NULL
    DROP EXTERNAL TABLE silver.rate_code

CREATE EXTERNAL TABLE silver.rate_code
    WITH(
        DATA_SOURCE = ContosoLake,
        LOCATION = '/lmman-practice-databricks/contosolake/silver/rate_code',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT rate_code_id, rate_code
    FROM OPENROWSET(
        BULK '/lmman-practice-databricks/contosolake/raw/rate_code.json',
        DATA_SOURCE = 'ContosoLake',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE = '0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH
    (
        jsonDoc NVARCHAR(MAX)
    ) AS rate_code
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        rate_code_id TINYINT,
        rate_code VARCHAR(20)
    );


SELECT * FROM silver.rate_code;




















