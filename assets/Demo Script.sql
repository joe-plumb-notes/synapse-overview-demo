-- What data do we have?
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://jadmadlsgen2.dfs.core.windows.net/nyctaxi/yellow/puYear=2014/puMonth=3/part-00104-tid-210938564719836543-aea5b543-5e83-4a7d-8d31-69f72c50b05d-15224-2.c000.snappy.parquet',
        FORMAT='PARQUET'
    ) AS [r]
;

-- How are trips split by vendors?
SELECT (nyc.VENDORID), (SUM(nyc.PASSENGERCOUNT)) as PASSENGERCOUNT
FROM
    OPENROWSET(
        BULK 'https://jadmadlsgen2.dfs.core.windows.net/nyctaxi/yellow/puYear=*/puMonth=*/*.parquet',
        FORMAT='PARQUET'
    ) AS [nyc]
WHERE nyc.filepath(1) >= '2009' AND nyc.filepath(1) <= '2019'
GROUP BY [nyc].[VENDORID];

-- Trips per year?
SELECT
    YEAR(tpepPickupDateTime) AS current_year,
    COUNT(*) AS rides_per_year
FROM
    OPENROWSET(
        BULK 'https://jadmadlsgen2.dfs.core.windows.net/nyctaxi/yellow/puYear=*/puMonth=*/*.parquet',
        FORMAT='PARQUET'
    ) AS [nyc]
WHERE nyc.filepath(1) >= '2009' AND nyc.filepath(1) <= '2019'
GROUP BY YEAR(tpepPickupDateTime)
ORDER BY 1 ASC;

-- Lets look at 2016 in more detail
SELECT
    CAST([tpepPickupDateTime] AS DATE) AS [current_day],
    COUNT(*) as rides_per_day
FROM
    OPENROWSET(
        BULK 'https://jadmadlsgen2.dfs.core.windows.net/nyctaxi/yellow/puYear=*/puMonth=*/*.parquet',
        FORMAT='PARQUET'
    ) AS [nyc]
WHERE nyc.filepath(1) = '2016'
GROUP BY CAST([tpepPickupDateTime] AS DATE)
ORDER BY 1 ASC;

-- Persist in SQL
CREATE EXTERNAL TABLE dbo.ridesperday (   
    current_day DATE,  
    rides_per_day INT   
    )  
    WITH (  
        LOCATION='/yellow/puYear=*/puMonth=*/*.parquet',  
        DATA_SOURCE = nyctaxi_jpadlsg2_dfs_core_windows_net,  
        FILE_FORMAT = Parquet)
    AS (
        SELECT
        CAST([tpepPickupDateTime] AS DATE) AS [current_day],
        COUNT(*) as rides_per_day
    FROM
        OPENROWSET(
            BULK 'https://jadmadlsgen2.dfs.core.windows.net/nyctaxi/yellow/puYear=*/puMonth=*/*.parquet',
            FORMAT='PARQUET'
        ) AS [nyc]
    WHERE nyc.filepath(1) = '2016'
    GROUP BY CAST([tpepPickupDateTime] AS DATE)
    ORDER BY 1 ASC;
    )  
;  
