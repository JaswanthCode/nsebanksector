CREATE TABLE market_data_raw (
    source_record_identifier BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    symbol VARCHAR(20),
    series VARCHAR(10),
    date1 VARCHAR(20),
    prev_close VARCHAR(30),
    open_price VARCHAR(30),
    high_price VARCHAR(30),
    low_price VARCHAR(30),
    last_price VARCHAR(30),
    close_price VARCHAR(30),
    avg_price VARCHAR(30),
    ttl_trd_qnty VARCHAR(30),
    turnover_lacs VARCHAR(30),
    no_of_trades VARCHAR(30),
    deliv_qty VARCHAR(30),
    deliv_per VARCHAR(30)
);


CREATE TABLE market_data_clean (
    source_record_identifier BIGINT,
    symbol VARCHAR(20),
    series VARCHAR(10),
    trade_date DATE,
    previous_close_price DECIMAL(18,4),
    open_price DECIMAL(18,4),
    high_price DECIMAL(18,4),
    low_price DECIMAL(18,4),
    last_price DECIMAL(18,4),
    close_price DECIMAL(18,4),
    average_price DECIMAL(18,4),
    total_traded_quantity BIGINT,
    turnover_lakhs DECIMAL(18,4),
    number_of_trades BIGINT,
    delivery_quantity BIGINT,
    delivery_percentage DECIMAL(10,4),

    PRIMARY KEY (symbol, trade_date)
);


CREATE TABLE bank_financial_data (
    symbol VARCHAR(20),
    company_name VARCHAR(100),
    period_end DATE,
    revenue_crore DECIMAL(18,2),
    profit_before_tax_crore DECIMAL(18,2),
    net_profit_crore DECIMAL(18,2),
    latest_price_to_book_ratio DECIMAL(12,2),
    latest_return_on_equity_percentage DECIMAL(12,2),

    PRIMARY KEY (symbol, period_end)
);
