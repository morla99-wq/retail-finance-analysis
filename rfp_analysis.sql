--==================================================
-- Retail Finance Performance Analysis - PostgresSQL
--==================================================

-- ---------
-- 1. Schema
-- ---------
CREATE TABLE transactionsb (
    transaction_id   TEXT,
    date             DATE,
    store_id         TEXT,
    store_name       TEXT,
    region           TEXT,
    product_category TEXT,
    product_name     TEXT,
    units_sold       INTEGER,
    unit_price       NUMERIC,
    unit_cost        NUMERIC,
    discount_pct     NUMERIC,
    revenue          NUMERIC,
    cost             NUMERIC,
    profit           NUMERIC,
    payment_method   TEXT,
    customer_segment TEXT
);

-- --------------------------------------------
-- 2. Data cleaning checks (Q1-3) - SQL version
-- --------------------------------------------
-- Q1: Find duplicates rows

SELECT
    date, store_id, product_category, product_name, units_sold,
    unit_price, payment_method, customer_segment,
    COUNT(*) AS occurrences
FROM transactions
GROUP BY date, store_id, product_category, product_name, units_sold,
         unit_price, payment_method, customer_segment
HAVING COUNT(*) > 1;

-- Q2: Count missing discount_pct values
SELECT COUNT(*) AS missing_discount_count
FROM transactions
WHERE discount_pct IS NULL;

-- Fill missing discoiunt_pct with 0 (Psql)
UPDATE transactions
SET discount_pct = 0
WHERE discount_pct IS NULL;

-- Q3: Standarized payment_method casing
SELECT DISTINCT payment_method FROM transactions;

UPDATE transactions
SET payment_method = INITCAP(payment_method);

-- ------------------------------
-- Q4: Analysis questions (Q4-10)
-- ------------------------------

-- Q4: Total revenue, cost profit by year
SELECT
	EXTRACT(YEAR from date) AS year,
	SUM(revenue) AS total_revenue,
	SUM(profit) AS total_profit,
	SUM(cost) AS total_cost
FROM transactions
GROUP by EXTRACT(YEAR FROM date)
ORDER BY year;

-- Q5: Revenue and profit margin by store, ranked
SELECT
	store_name,
	region,
	SUM(revenue) AS total_revenue,
	SUM(profit) AS total_profit,
	ROUND(SUM(profit)*100.0/NULLIF(SUM(revenue), 0), 2) AS profit_margin_pct
FROM transactions
GROUP BY store_name, region
ORDER BY total_revenue DESC;

-- Q6: Most profitable product category (by total profit margin %)
SELECT 
	product_category,
	SUM(revenue) AS total_revenue,
	SUM(profit) AS total_profit,
	ROUND(SUM(profit)*100.0/NULLIF(SUM(revenue), 0), 2) AS profit_margin_pct
FROM transactions
GROUP BY product_category
ORDER BY total_profit DESC;

-- Q7: Top 10 best-selling products by unit sold
SELECT
	product_name,
	product_category,
	SUM(units_sold) AS total_unit_sold,
	SUM(revenue) AS total_revenue
FROM transactions
GROUP BY product_name, product_category
ORDER BY total_unit_sold DESC
LIMIT 10;

-- Q8: Revenue breakdown by region
SELECT
	region,
	SUM(revenue) AS total_revenue,
	ROUND(SUM(revenue)*100.0/SUM(SUM(revenue)) OVER (), 2) AS pct_of_total_revenue
FROM transactions
GROUP BY region
ORDER BY pct_of_total_revenue DESC;

-- Q9: Transaction % and profitability by customer segment
SELECT
	customer_segment,
	COUNT(*) AS transaction_count,
	ROUND(COUNT(*) * 100.0/SUM(COUNT(*)) OVER (), 2) AS pct_of_transactions,
	SUM(profit) AS total_profit,
	ROUND(SUM(profit) * 100.0/NULLIF(SUM(revenue), 0), 2) AS profit_margin_pct
FROM transactions
GROUP BY customer_segment
ORDER BY pct_of_transactions DESC;

-- Q10: Payment method overal by region
--Overall
SELECT
	payment_method,
	COUNT(*) AS transactions_count,
	ROUND(COUNT(*) *100.0/SUM(COUNT(*)) OVER (), 2) AS pct_of_transactions
FROM transactions
GROUP BY payment_method
ORDER BY transactions_count DESC;

-- By region
SELECT
	region,
	payment_method,
	COUNT(*) AS transactions_count
FROM transactions
GROUP BY region, payment_method
ORDER BY region, transactions_count DESC;

	
