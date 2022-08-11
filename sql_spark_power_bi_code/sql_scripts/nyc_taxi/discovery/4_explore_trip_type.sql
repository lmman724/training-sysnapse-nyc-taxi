USE nyc_taxi_ldw;

SELECT *
  FROM OPENROWSET(
      BULK 'raw/trip_type.tsv',
      DATA_SOURCE = 'nyc_taxi_src',
      FORMAT = 'CSV',
      PARSER_VERSION = '2.0',
      HEADER_ROW = TRUE,
      FIELDTERMINATOR = '\t'
  ) AS trip_type;