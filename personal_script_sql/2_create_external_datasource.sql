USE nyc_taxi_ldw;

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyc_taxi_src')
    CREATE EXTERNAL DATA SOURCE nyc_taxi_src
    WITH
    (    LOCATION         = 'https://minhstorageaccount.blob.core.windows.net'
    );

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyc_taxi_ext')
    CREATE EXTERNAL DATA SOURCE nyc_taxi_ext WITH
    (
        LOCATION = 'https://minhstorageaccount.blob.core.windows.net'
    );