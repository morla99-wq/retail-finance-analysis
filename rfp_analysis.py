"""
Retail finance Performance Analysis - Python
Covers: data cleaning(Q1-3) and trend/relationship analysis (Q11-15)
"""

import pandas as pd
import matplotlib.pyplot as plt

#------------------
#Load
#------------------
df =pd.read_csv("business_finance_dataset.csv")
df["date"] = pd.to_datetime(df["date"])

print(f"Raw row count: {len(df)}")

#----------------------------
# Q1 - Duplicate Transactions
#----------------------------
dup_count = df.duplicated().sum()
print(f"\nQ1: Duplicated rows found: {dup_count}")

# Drop exact duplicates
df = df.drop_duplicates()
print(f"\nQ1: Row count after removing duplicates: {len(df)}")

#--------------------------
# Q2 - Missing discount_pct
#--------------------------
missing_discount = df["discount_pct"].isna().sum()
print(f"\nQ2: Rows with missing discount_pct: {missing_discount}")

# Reasenable assumption: a missing discount means no discount was applied
df["discount_pct"] = df["discount_pct"].fillna(0)
print(f"\nQ2: Filled missing discount_pct with 0")

#---------------------------------------
# Q3 - Standardize payment_method casing
#---------------------------------------
print(f"\nQ3: payment_method values before cleaning:")
print(df["payment_method"].unique())

df["payment-method"]= df["payment_method"].str.title()

print(f"\nQ3: payment_method values after cleaning:")
print(df["payment_method"].unique())

# Profit margin % column added
df["profit_margin_pct"] = (df["profit"]/df["revenue"]*100).round(2)

# Save the cleaned file - useful for SQL and visuals
df.to_csv("business_finance_dataset_clean.csv", index=False)

#---------------------------------------------------
# Q11 - Month over month revenue trend / seasonality 
#---------------------------------------------------
df["year_month"] = df["date"].dt.to_period("M")
monthly_revenue = df.groupby("year_month")["revenue"].sum()

print(f"\nQ11: Monthly revenue (first 5 rows):")
print(monthly_revenue.head())
monthly_revenue.plot(kind="line",figsize=(12, 5), marker="o",title="Monthly Revenue Trend")
plt.ylabel("Revenue ($)")
plt.xlabel("Month")
plt.tight_layout()
plt.savefig("monthly_revenue_trend.png")
plt.close()

#--------------------------------
# Q12 - Weekday vs. weekend sales
#--------------------------------
df["is_weekend"] = df["date"].dt.weekday >= 5

weekday_vs_weekend = df.groupby("is_weekend").agg(
    total_revenue=("revenue", "sum"),
    avg_revenue_per_txn=("revenue", "mean"),
    transactions_count=("transaction_id", "count"),
).rename(index={False: "Weekday", True: "Weekend"})

print(f"\nQ12: Weekday vs Weekend comparison:")
print(weekday_vs_weekend)

#-------------------------------------------
# Q13 - Discount vs units sold relationship
#-------------------------------------------
discount_vs_units = df.groupby("discount_pct")["units_sold"].mean().round()

print(f"\nQ13: Average units sold by discount %:")
print(discount_vs_units)

corr = df["discount_pct"].corr(df["units_sold"])
print(f"Q13: Correlation between discount_pct and units_sold: {corr:.3f}")

#--------------------------------------------------
# Q14 - Underperforming store/category combination
#--------------------------------------------------
store_category = df.groupby(["store_name", "product_category"]).agg(
    total_profit=("profit", "sum"),
    total_revenue=("revenue", "sum"),
    avg_margin_pct=("profit_margin_pct", "mean"),
).reset_index()

underperformers= store_category.sort_values("total_profit").head(10)

print("\Q14: 10 lowest-profit store/category combinations:")
print(underperformers)

#--------------------------------------------
# Q15 - Rank stores by average profit margin
#--------------------------------------------
store_margin_rank =(
    df.groupby("store_name")["profit_margin_pct"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print("\Q15: Store ranked by average profit margin %:")
print(store_margin_rank)

store_margin_rank.plot(kind="bar", figsize=(10, 5), title="Average Profit Margin % by Store")
plt.ylabel("profit Margin %")
plt.tight_layout()
plt.savefig("store_margin_ranking.png")
plt.close()

print("\nDone. Cleaned data saved to business_finace_dataset_clean.csv")