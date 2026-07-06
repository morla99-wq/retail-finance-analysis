# 📊 Retail Finance Performance Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Pandas-3776AB?logo=python&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-E97627?logo=tableau&logoColor=white)
![Status](https://img.shields.io/badge/status-complete-brightgreen)

A beginner-friendly end-to-end data analytics project — **data cleaning, SQL
analysis, Python exploration, and a Tableau dashboard** — built on a synthetic
retail finance dataset for a fictional 6-store chain, **GreenLeaf Retail Co.**

> 📌 **TL;DR:** Cleaned ~30,900 retail transactions, answered 20 business
> questions across SQL/Python/Tableau, and built an executive dashboard
> covering revenue, profit margin, and regional performance for 2023–2024.

---

## 🗂️ Table of Contents
- [Project Overview](#-project-overview)
- [Dataset](#-dataset)
- [Repo Structure](#-repo-structure)
- [Tech Stack](#-tech-stack)
- [Setup & How to Run](#-setup--how-to-run)
- [Questions Answered](#-questions-answered)
- [Key Insights](#-key-insights)
- [Dashboard Preview](#-dashboard-preview)
- [License](#-license)

---

## 🧭 Project Overview

GreenLeaf Retail Co. operates 6 stores across 4 US regions, selling
Electronics, Apparel, Home & Garden, Groceries, and Beauty products.
Leadership wants to understand sales and profitability trends from
**Jan 2023 – Dec 2024** to guide decisions on inventory, staffing, and
promotions.

This project walks through the full analytics workflow:
1. **Clean** messy raw data in Python
2. **Query** it in PostgreSQL for business KPIs
3. **Explore** trends and relationships in Python
4. **Visualize** findings in an interactive Tableau dashboard

---

## 📁 Dataset

**File:** [`business_finance_dataset.csv`](./business_finance_dataset.csv) (~30,900 rows)

| Column | Description |
|---|---|
| `transaction_id` | Unique transaction identifier |
| `date` | Transaction date (2023-01-01 to 2024-12-31) |
| `store_id`, `store_name`, `region` | Store location info (6 stores, 4 regions) |
| `product_category`, `product_name` | What was sold |
| `units_sold` | Quantity sold in the transaction |
| `unit_price`, `unit_cost` | List price and cost per unit |
| `discount_pct` | Discount applied (some missing values — for cleaning practice) |
| `revenue`, `cost`, `profit` | Calculated financial totals for the transaction |
| `payment_method` | Credit Card, Debit Card, Cash, Mobile Payment (some inconsistent casing — for cleaning practice) |
| `customer_segment` | New, Returning, VIP |

The data includes intentional messiness — a handful of duplicate rows, missing
`discount_pct` values, and inconsistent text casing — for realistic
data-cleaning practice.

---

## 📦 Repo Structure

```
retail-finance-analysis/
├── README.md
├── data/
│   ├── business_finance_dataset.csv        # raw data
│   └── business_finance_dataset_clean.csv  # output of python_analysis.py
├── python_analysis.py                      # cleaning + trend analysis
├── postgres_queries.sql                    # schema, load, and analysis queries
├── charts/
│   ├── monthly_revenue_trend.png
│   └── store_margin_ranking.png
└── tableau/
    └── retail_finance_dashboard.twbx        # Tableau workbook (add your own)
```

---

## 🛠️ Tech Stack

- **Python** — pandas, matplotlib (cleaning + exploratory analysis)
- **PostgreSQL** — aggregation and business-question queries
- **Tableau** — interactive dashboard for stakeholders

---

## 🚀 Setup & How to Run

### 1. Clone and install dependencies
```bash
git clone https://github.com/<your-username>/retail-finance-analysis.git
cd retail-finance-analysis
pip install pandas matplotlib
```

### 2. Run the Python analysis
```bash
python python_analysis.py
```
This cleans the raw CSV, prints answers to the cleaning/trend questions, and
saves `business_finance_dataset_clean.csv` plus two charts.

### 3. Load into PostgreSQL
```bash
psql -U <your_user> -d <your_database>
```
Then inside `psql`:
```sql
\i postgres_queries.sql
```
(Uncomment the `\copy` command in the file first and point it at your CSV path.)

### 4. Open the Tableau dashboard
Open `tableau/retail_finance_dashboard.twbx` in Tableau Desktop or Tableau
Public, or connect Tableau directly to `business_finance_dataset_clean.csv`.

---

## ❓ Questions Answered

<details>
<summary><strong>Data Cleaning</strong></summary>

1. How many duplicate transactions exist, and what's the cleaned row count?
2. How many rows have a missing `discount_pct`? How should they be handled?
3. Standardize `payment_method` so values are consistently capitalized.
</details>

<details>
<summary><strong>SQL — Aggregation</strong></summary>

4. Total revenue, cost, and profit: 2023 vs. 2024
5. Which store generates the most revenue / highest profit margin?
6. Most profitable product category (by total profit and margin %)
7. Top 10 best-selling products by units sold
8. Revenue breakdown by region
9. Transaction share and profitability by customer segment
10. Most common payment method, and how it varies by region
</details>

<details>
<summary><strong>Python — Trends</strong></summary>

11. Month-over-month revenue trend / seasonality
12. Weekday vs. weekend sales comparison
13. Relationship between discount % and units sold
14. Underperforming store/category combinations
15. Store ranking by average profit margin %
</details>

<details>
<summary><strong>Tableau — Dashboard</strong></summary>

16. Executive KPI dashboard (Revenue, Profit, Margin %) with year/region/category filters
17. Monthly revenue time series by store or region
18. Map view of revenue/profit by region
19. Category × segment profit heatmap
20. Parameter toggle between Revenue / Cost / Profit views
</details>

---

## 💡 Key Insights

> _Fill this in after you run your analysis — this section is what reviewers
> read first. Aim for 3-5 bullets framed as business takeaways, not just
> stats._

- e.g. *"Holiday months (Nov–Dec) drive ~60% more revenue than the yearly
  average — staffing and inventory should scale accordingly."*
- e.g. *"Groceries has the lowest margin (~10%) across every store; Beauty is
  the strongest at ~38%, suggesting a category mix shift could lift overall
  profitability."*
- e.g. *"Discount % showed almost no correlation with units sold in this
  data — promotions may not be the volume driver leadership assumes."*

---

## 🖼️ Dashboard Preview

> _Add a screenshot or GIF of your Tableau dashboard here once it's built:_
> `![Dashboard](./tableau/dashboard_preview.png)`

---

## 📄 License

This project uses a synthetic dataset created for portfolio/educational
purposes. Feel free to fork, adapt, and reuse.
# retail-finance-analysis
