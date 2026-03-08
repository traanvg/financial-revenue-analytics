# 📊 Financial Revenue Analytics Pipeline

An end-to-end data analytics project analyzing **$127M in revenue** across 5 business segments and 5 countries using SQL, Python, and Power BI.

---

## 📌 Business Questions Answered

- Which segment generates the most profit — and which is losing money?
- Which country has the best profit margin?
- How does discounting impact profitability?
- What is the monthly revenue trend over time?
- Which product drives the most revenue?
- Which segment dominates in each country?

---

## 🔑 Key Findings

| Finding | Detail |
|---|---|
| 💰 Total Revenue | $127,931,598 |
| 📈 Total Profit | $16,893,702 |
| 📊 Overall Margin | 13.21% |
| 🏆 Best Segment | Government — $11.4M profit |
| ⚠️ Worst Segment | Enterprise — **-$614K loss** despite $21M in sales |
| 🌍 Best Country | Germany — 14.77% margin |
| 🥇 Top Product | Paseo — $35.6M in revenue |
| 🎯 Discount Impact | High discounts cut profit margin by **64%** (21.86% → 7.94%) |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL (SQLite)** | Data extraction, aggregation, window functions |
| **Python (Pandas, Matplotlib, Seaborn)** | Data cleaning, EDA, visualizations |
| **Power BI** | Interactive dashboard, DAX measures, star schema |
| **DB Browser for SQLite** | SQL query execution |
| **Google Colab** | Python notebook environment |

---

## 📁 Project Structure

```
financial-revenue-analytics/
├── data/
│   └── financials.csv              ← Microsoft Financial Sample dataset
├── sql/
│   └── analysis.sql                ← 8 SQL queries with findings
├── python/
│   └── revenue_analysis.ipynb      ← Python EDA notebook (Google Colab)
├── powerbi/
│   └── dashboard.pbix              ← Power BI dashboard (coming soon)
├── screenshots/
│   ├── segment_profit.png
│   ├── discount_impact.png
│   ├── monthly_trend.png
│   └── correlation_heatmap.png
└── README.md
```

---

## 🗄️ Phase 1 — SQL Analysis

**Tool:** SQLite via DB Browser  
**File:** `sql/analysis.sql`

Wrote 8 queries covering aggregation, filtering, and window functions to answer core business questions.

**SQL concepts demonstrated:**
- `SUM`, `AVG`, `COUNT` with `GROUP BY`
- Profit margin calculation using `SUM/SUM * 100`
- `HAVING` clause for post-aggregation filtering
- `RANK() OVER (PARTITION BY)` for ranking within groups
- `SUM() OVER (ORDER BY)` for running totals
- Date extraction using `substr()`

**Key SQL Finding — Discount Impact:**
```sql
SELECT "Discount Band",
       ROUND(SUM(CAST("Profit" AS REAL)) / SUM(CAST("Gross Sales" AS REAL)) * 100, 2) AS Profit_Margin_Pct
FROM financials
GROUP BY "Discount Band"
ORDER BY Profit_Margin_Pct DESC;
```

Result:
```
None    → 21.86%
Low     → 17.43%
Medium  → 13.35%
High    →  7.94%
```

**Key SQL Finding — Enterprise Losing Money:**
```sql
SELECT Segment,
       ROUND(SUM(CAST("Gross Sales" AS REAL)), 2) AS Total_Gross_Sales,
       ROUND(SUM(CAST("Profit" AS REAL)), 2) AS Total_Profit
FROM financials
GROUP BY Segment
ORDER BY Total_Profit DESC;
```

Result: Enterprise has $21M in sales but -$614K profit — spending 96 cents for every dollar earned.

---

## 🐍 Phase 2 — Python Analysis

**Tool:** Python (Pandas, Matplotlib, Seaborn) in Google Colab  
**File:** `python/revenue_analysis.ipynb`

**Steps performed:**
1. Loaded and inspected dataset (700 rows, 16 columns)
2. Cleaned data — filled 53 missing Discount Band values with "None"
3. Converted Date column to datetime and extracted Year/Month
4. Visualized segment profitability (Enterprise shown in red for negative profit)
5. Visualized discount impact on profit margin
6. Plotted monthly revenue trend (2013–2014)
7. Generated correlation heatmap across key financial metrics
8. Printed full summary of key findings

**Key Python Finding — Correlation Analysis:**

| Metric Pair | Correlation | Meaning |
|---|---|---|
| Gross Sales vs COGS | 0.99 | Costs scale perfectly with revenue — no economies of scale |
| Gross Sales vs Profit | 0.78 | Strong but discounts reduce it |
| Discounts vs Profit | 0.38 | Weak — discounts don't generate enough volume to justify margin loss |
| Units Sold vs Profit | 0.23 | Very weak — volume alone doesn't drive profit |

**Chart Previews:**

### Segment Profitability
![Segment Profit](screenshots/segment_profit.png)

### Discount Impact on Profit Margin
![Discount Impact](screenshots/discount_impact.png)

### Monthly Revenue Trend
![Monthly Trend](screenshots/monthly_trend.png)

### Correlation Heatmap
![Correlation](screenshots/correlation_heatmap.png)

---

## 📊 Phase 3 — Power BI Dashboard

**Tool:** Power BI Desktop  
**File:** `powerbi/dashboard.pbix`

*(Coming soon — in progress)*

Planned features:
- Star schema data model with 3 dimension tables (DimDate, DimSegment, DimCountry)
- Page 1: Revenue overview with KPI cards, trend line, segment bar chart, country map
- Page 2: Drill-through detail with waterfall chart and product matrix
- 5 DAX measures: Net Profit Margin %, COGS Ratio %, Discount Impact %, MoM Growth %, YTD Revenue

---

## 📂 Dataset

**Source:** [Microsoft Financial Sample](https://learn.microsoft.com/en-us/power-bi/create-reports/sample-financial-download)  
**Size:** 700 rows, 16 columns  
**Period:** September 2013 — December 2014  
**Segments:** Government, Small Business, Channel Partners, Midmarket, Enterprise  
**Countries:** USA, Canada, France, Germany, Mexico

---

## 💡 Business Recommendations

Based on the analysis:

1. **Review Enterprise pricing strategy** — the segment is generating negative profit despite significant revenue. COGS is 96% of sales before discounts are applied.

2. **Reduce high-discount sales** — high discount band reduces profit margin by 64% (21.86% → 7.94%). The data shows discount volume doesn't compensate for margin loss.

3. **Double down on Government segment** — highest absolute profit at $11.4M and consistent #1 ranking in every country.

4. **Focus on Germany and France** — best profit margins internationally at 14.77% and 14.50% respectively.

5. **Investigate October seasonality** — October is consistently the peak revenue month. Pre-positioning inventory and staffing could maximize this window.

---

## 👤 Author

**Tran Vuong**  
[LinkedIn](https://linkedin.com/in/tranvuong0629) | [GitHub](https://github.com/traanvg)
