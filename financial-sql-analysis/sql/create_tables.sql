-- ================================================
-- Financial Market Analysis - Table Definitions
-- Database: PostgreSQL (Supabase)
-- ================================================

-- Stock daily prices and returns
CREATE TABLE IF NOT EXISTS stock_prices (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    open_price DECIMAL(10,2),
    high_price DECIMAL(10,2),
    low_price DECIMAL(10,2),
    close_price DECIMAL(10,2),
    adj_close DECIMAL(10,2),
    volume BIGINT,
    daily_return DECIMAL(10,6),
    UNIQUE(ticker, date)
);

-- Company reference data
CREATE TABLE IF NOT EXISTS company_info (
    ticker VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(100),
    sector VARCHAR(50),
    industry VARCHAR(100),
    market_cap BIGINT
);

-- Monthly aggregated metrics
CREATE TABLE IF NOT EXISTS monthly_summary (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10),
    year INT,
    month INT,
    avg_close DECIMAL(10,2),
    avg_volume BIGINT,
    monthly_return DECIMAL(10,6),
    volatility DECIMAL(10,6),
    UNIQUE(ticker, year, month)
);