-- ==========================================================
-- SUPERMARKET SALES ANALYSIS: DATA ENGINEERING & EDA
-- Author: Ahmed Hany
-- Database: supermarket_sales_db | Table: sales
-- ==========================================================

-- 1. DATABASE SETUP & DATA LOADING
-- Fixing date format issue encountered during CSV import
ALTER DATABASE supermarket_sales_db SET datestyle TO "ISO, MDY";

-- Table 'sales' structure assumed based on import
-- (Ensure column names match your pgAdmin import exactly)

-- 2. DATA INTEGRITY & VALIDATION
-- Confirmed 1,000 unique transactions
SELECT COUNT(*) FROM sales; 

-- Financial Integrity Check: Verifying Total = COGS + Tax (5%)
-- Logic: Finding 1 - Financial Accuracy within 0.01 margin
SELECT 
    invoice_id, 
    total, 
    (cogs + tax_5_percent) AS calculated_total,
    ABS(total - (cogs + tax_5_percent)) AS variance
FROM sales
WHERE ABS(total - (cogs + tax_5_percent)) > 0.01;

-- 3. EXPLORATORY DATA ANALYSIS (EDA)
-- Finding 2: Peak Transaction Times (The "Rush Hour" Analysis)
-- Identifying 1 PM, 3 PM, and 7 PM as primary traffic spikes
SELECT 
    EXTRACT(HOUR FROM time) AS hour_of_day,
    COUNT(*) AS transaction_count
FROM sales
GROUP BY hour_of_day
ORDER BY transaction_count DESC;

-- Finding 3: Branch Parity
-- Analysis showing Alex and Cairo have nearly identical sales numbers
SELECT 
    branch, 
    city, 
    ROUND(SUM(total)::numeric, 2) AS total_sales
FROM sales
GROUP BY branch, city
ORDER BY total_sales DESC;

-- 4. ADVANCED ANALYTICS (Demonstrating Window Functions & CTEs)
-- Logic: Ranking Product Lines by Revenue within each Branch
SELECT 
    branch, 
    product_line, 
    SUM(total) AS revenue,
    RANK() OVER(PARTITION BY branch ORDER BY SUM(total) DESC) as sales_rank
FROM sales
GROUP BY branch, product_line;

-- Logic: Classifying Transactions by Size (High Value vs Standard)
-- Using CTE to determine the global average sale
WITH GlobalAvg AS (
    SELECT AVG(total) as avg_val FROM sales
)
SELECT 
    invoice_id,
    branch,
    total,
    CASE 
        WHEN total > (SELECT avg_val FROM GlobalAvg) THEN 'High Value'
        ELSE 'Standard'
    END AS transaction_category
FROM sales;