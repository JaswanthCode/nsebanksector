DELETE FROM market_data_clean;


WITH ranked_market_data AS (
    SELECT
        source_record_identifier,
        TRIM(symbol) AS symbol,
        TRIM(series) AS series,
        TRIM(date1) AS date1,
        prev_close,
        open_price,
        high_price,
        low_price,
        last_price,
        close_price,
        avg_price,
        ttl_trd_qnty,
        turnover_lacs,
        no_of_trades,
        deliv_qty,
        deliv_per,

        ROW_NUMBER() OVER (
            PARTITION BY TRIM(symbol), TRIM(date1)
            ORDER BY source_record_identifier
        ) AS row_number

    FROM market_data_raw
)

INSERT INTO market_data_clean (
    source_record_identifier,
    symbol,
    series,
    trade_date,
    previous_close_price,
    open_price,
    high_price,
    low_price,
    last_price,
    close_price,
    average_price,
    total_traded_quantity,
    turnover_lakhs,
    number_of_trades,
    delivery_quantity,
    delivery_percentage
)

SELECT
    source_record_identifier,
    symbol,
    series,

    CAST(
        SUBSTRING(date1 FROM 8 FOR 4)
        || '-'
        ||
        CASE SUBSTRING(date1 FROM 4 FOR 3)
            WHEN 'Jan' THEN '01'
            WHEN 'Feb' THEN '02'
            WHEN 'Mar' THEN '03'
            WHEN 'Apr' THEN '04'
            WHEN 'May' THEN '05'
            WHEN 'Jun' THEN '06'
            WHEN 'Jul' THEN '07'
            WHEN 'Aug' THEN '08'
            WHEN 'Sep' THEN '09'
            WHEN 'Oct' THEN '10'
            WHEN 'Nov' THEN '11'
            WHEN 'Dec' THEN '12'
        END
        || '-'
        ||
        SUBSTRING(date1 FROM 1 FOR 2)
        AS DATE
    ),

    CAST(NULLIF(TRIM(prev_close), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(open_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(high_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(low_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(last_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(close_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(avg_price), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(ttl_trd_qnty), '') AS BIGINT),
    CAST(NULLIF(TRIM(turnover_lacs), '') AS DECIMAL(18,4)),
    CAST(NULLIF(TRIM(no_of_trades), '') AS BIGINT),
    CAST(NULLIF(TRIM(deliv_qty), '') AS BIGINT),
    CAST(NULLIF(TRIM(deliv_per), '') AS DECIMAL(10,4))

FROM ranked_market_data

WHERE row_number = 1;
