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


Technologies Used
- Python
- Pandas
- Requests
- PostgreSQL
- SQL
- Git
- GitHub
Data
Market Data
Daily NSE Bhavcopy files are downloaded for April 2026 through September 2026.
The Python processing script:
- Reads the configured banking stock symbols
- Filters equity-series records
- Combines daily Bhavcopy files
- Preserves the original NSE market-data schema
The consolidated raw market dataset contains:
- 41 banking stocks
- 6,271 raw market records
- 124 unique trading dates
SQL data-quality checks identified duplicate bank/date records in the source-derived data.
After SQL deduplication:
- 5,049 clean market records
- 0 duplicate bank/date combinations
Financial Data
The financial dataset contains two quarterly periods:
- March 31, 2026
- June 30, 2026
The dataset contains 82 records:
- 41 banks
- 2 quarters per bank
Financial metrics include:
- Revenue
- Profit Before Tax
- Net Profit
- Latest Price-to-Book Ratio
- Latest Return on Equity Percentage
SQL Analysis
The SQL analysis focuses on three areas:
1. Quarterly financial performance change from March to June 2026
2. Stock-price movement from July to September 2026
3. Comparison of financial improvement with subsequent stock-price movement
The analysis identifies patterns such as:
- Profit up and stock up
- Profit down and stock down
- Profit up and stock down
- Profit down and stock up
These patterns are used to study association between financial performance and market movement.
Important Note
The project studies relationships between quarterly financial performance and subsequent stock-price movement.
It does not claim that quarterly financial results alone cause stock-price changes, because market prices can also be affected by broader market conditions, interest rates, monetary policy, expectations, and company-specific news.
Purpose
The main purpose of this project is to demonstrate practical Data Engineering skills including:
- API/file-based data ingestion
- Raw and processed data layers
- Data filtering and consolidation
- PostgreSQL staging
- SQL data cleaning
- Duplicate handling
- Data type conversion
- SQL joins
- Common Table Expressions
- Financial and market-data integration
- Reproducible ETL workflow
