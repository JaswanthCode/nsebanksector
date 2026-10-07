-- 1. Quarterly financial performance

SELECT
    june.symbol,

    ROUND(
        CASE
            WHEN march.revenue_crore = 0 THEN NULL
            ELSE ((june.revenue_crore - march.revenue_crore)
                 / march.revenue_crore) * 100
        END,
        2
    ) AS revenue_growth_percentage,

    ROUND(
        CASE
            WHEN march.profit_before_tax_crore = 0 THEN NULL
            ELSE ((june.profit_before_tax_crore - march.profit_before_tax_crore)
                 / march.profit_before_tax_crore) * 100
        END,
        2
    ) AS profit_before_tax_growth_percentage,

    june.net_profit_crore - march.net_profit_crore
        AS net_profit_change_crore,

    ROUND(
        CASE
            WHEN march.net_profit_crore <= 0 THEN NULL
            ELSE ((june.net_profit_crore - march.net_profit_crore)
                 / march.net_profit_crore) * 100
        END,
        2
    ) AS net_profit_growth_percentage

FROM bank_financial_data AS march

INNER JOIN bank_financial_data AS june
    ON march.symbol = june.symbol

WHERE march.period_end = DATE '2026-03-31'
AND june.period_end = DATE '2026-06-30'

ORDER BY june.symbol;

-- 2. Subsequent stock price performance

WITH price_dates AS (
    SELECT
        symbol,
        MIN(trade_date) AS start_date,
        MAX(trade_date) AS end_date
    FROM market_data_clean
    WHERE trade_date BETWEEN DATE '2026-07-01'
                         AND DATE '2026-09-30'
    GROUP BY symbol
)

SELECT
    dates.symbol,
    start_price.close_price AS july_start_price,
    end_price.close_price AS september_end_price,

    ROUND(
        CASE
            WHEN start_price.close_price = 0 THEN NULL
            ELSE ((end_price.close_price - start_price.close_price)
                 / start_price.close_price) * 100
        END,
        2
    ) AS stock_price_change_percentage

FROM price_dates AS dates

INNER JOIN market_data_clean AS start_price
    ON dates.symbol = start_price.symbol
    AND dates.start_date = start_price.trade_date

INNER JOIN market_data_clean AS end_price
    ON dates.symbol = end_price.symbol
    AND dates.end_date = end_price.trade_date

ORDER BY stock_price_change_percentage DESC;

-- 3. Financial performance vs stock price performance

WITH financial_change AS (
    SELECT
        june.symbol,

        ROUND(
            CASE
                WHEN march.revenue_crore = 0 THEN NULL
                ELSE ((june.revenue_crore - march.revenue_crore)
                     / march.revenue_crore) * 100
            END,
            2
        ) AS revenue_growth_percentage,

        june.net_profit_crore - march.net_profit_crore
            AS net_profit_change_crore,

        ROUND(
            CASE
                WHEN march.net_profit_crore <= 0 THEN NULL
                ELSE ((june.net_profit_crore - march.net_profit_crore)
                     / march.net_profit_crore) * 100
            END,
            2
        ) AS net_profit_growth_percentage,

        june.latest_price_to_book_ratio,
        june.latest_return_on_equity_percentage

    FROM bank_financial_data AS march

    INNER JOIN bank_financial_data AS june
        ON march.symbol = june.symbol

    WHERE march.period_end = DATE '2026-03-31'
    AND june.period_end = DATE '2026-06-30'
),

price_dates AS (
    SELECT
        symbol,
        MIN(trade_date) AS start_date,
        MAX(trade_date) AS end_date
    FROM market_data_clean
    WHERE trade_date BETWEEN DATE '2026-07-01'
                         AND DATE '2026-09-30'
    GROUP BY symbol
),

market_change AS (
    SELECT
        dates.symbol,

        ROUND(
            CASE
                WHEN start_price.close_price = 0 THEN NULL
                ELSE ((end_price.close_price - start_price.close_price)
                     / start_price.close_price) * 100
            END,
            2
        ) AS stock_price_change_percentage

    FROM price_dates AS dates

    INNER JOIN market_data_clean AS start_price
        ON dates.symbol = start_price.symbol
        AND dates.start_date = start_price.trade_date

    INNER JOIN market_data_clean AS end_price
        ON dates.symbol = end_price.symbol
        AND dates.end_date = end_price.trade_date
)

SELECT
    financial.symbol,
    financial.revenue_growth_percentage,
    financial.net_profit_change_crore,
    financial.net_profit_growth_percentage,
    market.stock_price_change_percentage,
    financial.latest_price_to_book_ratio,
    financial.latest_return_on_equity_percentage,

    CASE
        WHEN financial.net_profit_change_crore > 0
             AND market.stock_price_change_percentage > 0
            THEN 'Profit up, stock up'

        WHEN financial.net_profit_change_crore < 0
             AND market.stock_price_change_percentage < 0
            THEN 'Profit down, stock down'

        WHEN financial.net_profit_change_crore > 0
             AND market.stock_price_change_percentage < 0
            THEN 'Profit up, stock down'

        WHEN financial.net_profit_change_crore < 0
             AND market.stock_price_change_percentage > 0
            THEN 'Profit down, stock up'

        ELSE 'No clear change'
    END AS performance_pattern

FROM financial_change AS financial

INNER JOIN market_change AS market
    ON financial.symbol = market.symbol

ORDER BY market.stock_price_change_percentage DESC;
