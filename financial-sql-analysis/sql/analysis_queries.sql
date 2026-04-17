-- ================================================
-- Financial Market Analysis - Business Questions
-- ================================================

-- Q1: Which stock had the highest average daily return?
-- Includes Sharpe ratio (return per unit of risk)
SELECT 
    c.company_name,
    s.ticker,
    ROUND(CAST(AVG(s.daily_return) * 100 AS NUMERIC), 4) AS avg_daily_return_pct,
    ROUND(CAST(STDDEV(s.daily_return) * 100 AS NUMERIC), 4) AS volatility_pct,
    ROUND(CAST(AVG(s.daily_return) / 
        NULLIF(STDDEV(s.daily_return), 0) AS NUMERIC), 4) AS sharpe_ratio
FROM stock_prices s
JOIN company_info c ON s.ticker = c.ticker
GROUP BY c.company_name, s.ticker
ORDER BY avg_daily_return_pct DESC;

-- Q2: Which months are historically most volatile?
SELECT 
    TO_CHAR(TO_DATE(month::TEXT, 'MM'), 'Month') AS month_name,
    month,
    ROUND(CAST(AVG(volatility) AS NUMERIC), 6) AS avg_volatility,
    ROUND(CAST(AVG(monthly_return) AS NUMERIC), 4) AS avg_monthly_return
FROM monthly_summary
GROUP BY month
ORDER BY avg_volatility DESC;

-- Q3: Top 10 best single-day returns
SELECT 
    c.company_name,
    s.ticker,
    s.date,
    ROUND(CAST(s.daily_return * 100 AS NUMERIC), 2) AS return_pct,
    s.volume
FROM stock_prices s
JOIN company_info c ON s.ticker = c.ticker
ORDER BY s.daily_return DESC
LIMIT 10;

-- Q3b: Top 10 worst single-day returns
SELECT 
    c.company_name,
    s.ticker,
    s.date,
    ROUND(CAST(s.daily_return * 100 AS NUMERIC), 2) AS return_pct,
    s.volume
FROM stock_prices s
JOIN company_info c ON s.ticker = c.ticker
ORDER BY s.daily_return ASC
LIMIT 10;

-- Q4: Stock correlation analysis
-- How strongly do stocks move together?
SELECT 
    a.ticker AS stock_1,
    b.ticker AS stock_2,
    ROUND(CAST(CORR(a.daily_return, b.daily_return) 
        AS NUMERIC), 4) AS correlation
FROM stock_prices a
JOIN stock_prices b 
    ON a.date = b.date 
    AND a.ticker < b.ticker
GROUP BY a.ticker, b.ticker
ORDER BY correlation DESC;

-- Q5: Does high trading volume predict bigger price moves?
SELECT 
    c.company_name,
    s.ticker,
    ROUND(CAST(CORR(s.volume, ABS(s.daily_return)) 
        AS NUMERIC), 4) AS volume_return_correlation,
    ROUND(CAST(AVG(CASE WHEN s.volume > avg_vol.avg_volume 
        THEN ABS(s.daily_return) * 100 END) 
        AS NUMERIC), 4) AS high_vol_day_avg_move_pct,
    ROUND(CAST(AVG(CASE WHEN s.volume <= avg_vol.avg_volume 
        THEN ABS(s.daily_return) * 100 END) 
        AS NUMERIC), 4) AS low_vol_day_avg_move_pct
FROM stock_prices s
JOIN company_info c ON s.ticker = c.ticker
JOIN (
    SELECT ticker, AVG(volume) AS avg_volume 
    FROM stock_prices 
    GROUP BY ticker
) avg_vol ON s.ticker = avg_vol.ticker
GROUP BY c.company_name, s.ticker
ORDER BY volume_return_correlation DESC;