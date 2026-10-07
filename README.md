# NSE Banking Sector ETL Analysis

## Project Objective

This project analyzes how quarterly financial performance relates to subsequent stock-price movement across selected NSE-listed banking stocks.

The project combines:

- NSE Bhavcopy market data
- Quarterly banking financial data
- Python data ingestion and processing
- PostgreSQL data cleaning
- SQL-based financial and market analysis

## Project Flow

```text
Bank Stock Configuration
        ↓
NSE Bhavcopy Download
        ↓
Raw Daily CSV Files
        ↓
Python Processing
        ↓
Consolidated Market Data
        ↓
PostgreSQL Raw Table
        ↓
SQL Cleaning and Deduplication
        ↓
Clean Market Data
        +
Quarterly Financial Data
        ↓
SQL Analysis
        ↓
Financial Performance vs Stock-Price Movement
```

## Repository Structure

```text
nsebanksector/
├── config/
│   └── bank_stocks.csv
├── data/
│   ├── raw/
│   │   └── bhavcopy/
│   └── processed/
│       ├── bank_financial_data.csv
│       └── market_data.csv
├── src/
│   ├── download_bhavcopy.py
│   └── process_market_data.py
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_clean_market_data.sql
│   └── 03_analysis.sql
├── .gitignore
└── README.md
```

## Technologies Used

- Python
- Pandas
- Requests
- PostgreSQL
- SQL
- Git
- GitHub

## Market Data

Daily NSE Bhavcopy files are downloaded for April 2026 through September 2026.

The Python processing stage:

- Reads the configured banking stock symbols
- Filters equity-series records
- Combines daily Bhavcopy files
- Preserves the original NSE market-data schema

The consolidated source-derived market dataset contains:

- 41 banking stocks
- 6,271 market records
- 124 unique trading dates

SQL data-quality checks identified duplicate bank/date records in the source-derived data.

After SQL deduplication:

- 5,049 clean market records
- 0 duplicate bank/date combinations

## Financial Data

The financial dataset contains two quarterly periods:

- March 31, 2026
- June 30, 2026

The dataset contains:

- 82 financial records
- 41 banks
- 2 quarterly records per bank

Financial metrics include:

- Revenue
- Profit Before Tax
- Net Profit
- Latest Price-to-Book Ratio
- Latest Return on Equity Percentage

The Price-to-Book Ratio and Return on Equity fields are latest snapshot metrics and are used as supporting valuation and profitability measures rather than quarter-over-quarter values.

## SQL Data Cleaning

The raw market data is loaded into PostgreSQL before transformation.

SQL is used to:

- Detect duplicate bank/date records
- Remove duplicate records using `ROW_NUMBER()`
- Convert source text values into appropriate numeric and date data types
- Create a clean analytical market-data table

## SQL Analysis

The analysis focuses on three areas:

1. Financial performance change from March to June 2026
2. Stock-price movement from July to September 2026
3. Comparison of financial improvement with subsequent stock-price movement

The final analysis identifies patterns such as:

- Profit up and stock up
- Profit down and stock down
- Profit up and stock down
- Profit down and stock up

These patterns help identify alignment and divergence between quarterly financial performance and subsequent market performance.

## Important Note

This project studies the relationship between quarterly financial performance and subsequent stock-price movement.

It does not claim that quarterly financial results alone cause stock-price changes. Market prices can also be influenced by broader market conditions, interest rates, monetary policy, investor expectations, and company-specific developments.

## Data Engineering Skills Demonstrated

This project demonstrates:

- HTTP and file-based data ingestion
- Raw and processed data layers
- Data filtering and consolidation with Python
- PostgreSQL staging tables
- SQL data-quality checks
- Duplicate handling
- Data type conversion
- SQL joins
- Common Table Expressions
- Window functions
- Financial and market-data integration
- Reproducible ETL workflow
