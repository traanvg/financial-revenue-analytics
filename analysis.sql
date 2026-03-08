-- ============================================
-- Financial Revenue Analytics — SQL Analysis
-- Dataset: Microsoft Financial Sample
-- Tool: SQLite
-- ============================================

-- ============================================
-- Q1: Which segment generates the most profit?
-- Finding: Government leads at $11.4M profit.
-- Enterprise loses money despite $21M in sales.
-- ============================================
SELECT Segment,
       ROUND(SUM(CAST("Gross Sales" AS REAL)), 2) AS Total_Gross_Sales,
       ROUND(SUM(CAST("COGS" AS REAL)), 2) AS Total_COGS,
       ROUND(SUM(CAST("Profit" AS REAL)), 2) AS Total_Profit
FROM financials
GROUP BY Segment
ORDER BY Total_Profit DESC;

-- ============================================
-- Q2: Which country has the best profit margin?
-- Finding: Germany leads at 14.77%.
-- USA is lowest at 10.99%.
-- ============================================
SELECT Country,
       ROUND(SUM(CAST("Profit" AS REAL)) / SUM(CAST("Gross Sales" AS REAL)) * 100, 2) AS Profit_Margin_Pct
FROM financials
GROUP BY Country
ORDER BY Profit_Margin_Pct DESC;

-- ============================================
-- Q3: Which 5 products drive the most revenue?
-- Finding: Paseo is #1 at $35.6M.
-- VTT and Velo round out the top 3.
-- ============================================
SELECT Product,
       ROUND(SUM(CAST("Gross Sales" AS REAL)), 2) AS Total_Sales
FROM financials
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 5;

-- ============================================
-- Q4: What is the monthly revenue trend?
-- Finding: June is peak month at $10.3M.
-- Revenue dips in March and May — seasonal pattern.
-- ============================================
SELECT substr("Date", 1, 7) AS Month,
       ROUND(SUM(CAST("Gross Sales" AS REAL)), 2) AS Monthly_Revenue
FROM financials
GROUP BY substr("Date", 1, 7)
ORDER BY Month;

-- ============================================
-- Q5: How does discounting impact profit margin?
-- Finding: No discount = 21.86% margin.
-- High discount = only 7.94% margin.
-- High discounts cut profit margin by 64% — critical business risk.
-- ============================================
SELECT "Discount Band",
       ROUND(SUM(CAST("Profit" AS REAL)) / SUM(CAST("Gross Sales" AS REAL)) * 100, 2) AS Profit_Margin_Pct,
       ROUND(AVG(CAST("Gross Sales" AS REAL)), 2) AS Avg_Sales
FROM financials
GROUP BY "Discount Band"
ORDER BY Profit_Margin_Pct DESC;

-- ============================================
-- Q6: Which segment ranks #1 in each country?
-- Finding: Government is #1 in every single country.
-- Channel Partners is always last.
-- Uses window function: RANK() OVER (PARTITION BY)
-- ============================================
SELECT Country, Segment,
       ROUND(SUM(CAST("Gross Sales" AS REAL)), 2) AS Total_Sales,
       RANK() OVER (PARTITION BY Country ORDER BY SUM(CAST("Gross Sales" AS REAL)) DESC) AS Rank_In_Country
FROM financials
GROUP BY Country, Segment;

-- ============================================
-- Q7: Is profit growing over time? (Running Total)
-- Finding: Profit grows consistently month over month.
-- Uses window function: SUM() OVER (ORDER BY)
-- ============================================
SELECT substr("Date", 1, 7) AS Month,
       ROUND(SUM(CAST("Profit" AS REAL)), 2) AS Monthly_Profit,
       ROUND(SUM(SUM(CAST("Profit" AS REAL))) OVER (ORDER BY substr("Date", 1, 7)), 2) AS Running_Total_Profit
FROM financials
GROUP BY substr("Date", 1, 7)
ORDER BY Month;

-- ============================================
-- Q8: Which segment + country combination is most profitable?
-- Finding: Government + Germany = best margin at 22.29%.
-- Government + France = highest absolute profit at $2.7M.
-- ============================================
SELECT Segment, Country,
       ROUND(SUM(CAST("Profit" AS REAL)), 2) AS Total_Profit,
       ROUND(SUM(CAST("Profit" AS REAL)) / SUM(CAST("Gross Sales" AS REAL)) * 100, 2) AS Profit_Margin_Pct
FROM financials
GROUP BY Segment, Country
ORDER BY Total_Profit DESC
LIMIT 10;
