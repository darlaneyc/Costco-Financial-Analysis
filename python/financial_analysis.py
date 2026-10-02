import pandas as pd

income_statement = pd.read_excel(
    "data/raw/costco_financials.xlsx",
    sheet_name = "Income Statement"
)

balance_sheet = pd.read_excel(
    "data/raw/costco_financials.xlsx",
    sheet_name = "Balance Sheet"
)

# Merges the two DataFrames using Fiscal Year as the common column
financial_data = pd.merge(
    income_statement,
    balance_sheet,
    on = "Fiscal Year"
)

print("\nCombined Financial Data:")
print(financial_data)

# Calculate year-over-year revenue growth
financial_data["Revenue Growth (%)"] = (
    financial_data["Total Revenue"].pct_change() * 100
).round(2)

print("\nRevenue Growth:")
print(financial_data[
    ["Fiscal Year", "Total Revenue", "Revenue Growth (%)"]
])

# Calculate Operating Margin
financial_data["Operating Margin (%)"] = (
    (financial_data["Operating Income"] / financial_data["Total Revenue"]) * 100
).round(2)

print("\nOperating Margin:")
print(financial_data[
    ["Fiscal Year", "Operating Income", "Total Revenue", "Operating Margin (%)"]
])

# Calculate Net Profit Margin
financial_data["Net Profit Margin (%)"] = (
    (financial_data["Net Income"] / financial_data["Total Revenue"]) * 100
).round(2)

print("\n Net Profit Margin:")
print(financial_data[
    ["Fiscal Year", "Net Income", "Total Revenue", "Net Profit Margin (%)"]
])

#Calculating the Current Ratio
financial_data["Current Ratio"] = (
    financial_data["Total Current Assets"] / financial_data["Total Current Liabilities"]
).round(2)

print("\nCurrent Ratio")
print(financial_data[
    ["Fiscal Year", "Total Current Assets", "Total Current Liabilities", "Current Ratio"]
])

#Calculating Debt-to-Equity Ratio
financial_data["Long-Term Debt-to-Equity Ratio"] = (
    financial_data["Long-Term Debt"] / financial_data["Stockholders' Equity"]
).round(2)

print("\nLong-Term Debt-to-Equity Ratio")
print(financial_data[
    ["Fiscal Year", "Long-Term Debt", "Stockholders' Equity", "Long-Term Debt-to-Equity Ratio"]
])

# Calculate Membership Fee Growth (%)
financial_data["Membership Fee Growth (%)"] = (
    financial_data["Membership Fees"].pct_change() * 100
).round(2)

print("\nMembership Fee Growth:")
print(financial_data[
    ["Fiscal Year", "Membership Fees", "Membership Fee Growth (%)"]
])

#Calculating Membership Fee Revenue Share
financial_data["Membership Fee Revenue Share (%)"] = (
    (financial_data["Membership Fees"] / financial_data["Total Revenue"]) * 100
).round(2)

print("\nMembership Fee Revenue Share (%)")
print(financial_data[
    ["Fiscal Year", "Membership Fees", "Total Revenue", "Membership Fee Revenue Share (%)"]
])

#Calculating Merchandise Cost Ratio
financial_data["Merchandise Cost Ratio (%)"] = (
    (financial_data["Merchandise Costs"] / financial_data["Total Revenue"]) * 100
).round(2)

print("\nMerchandise Cost Ratio (%)")
print(financial_data[
    ["Fiscal Year", "Merchandise Costs", "Total Revenue", "Merchandise Cost Ratio (%)"]
])

#Calculating SG&A Ratio
financial_data["SG&A Ratio (%)"] = (
    (financial_data["SG&A"] / financial_data["Total Revenue"]) * 100
).round(2)

print("\nSG&A Ratio (%)")
print(financial_data[
    ["Fiscal Year", "SG&A", "Total Revenue", "SG&A Ratio (%)"]
])

# Export cleaned financial data
financial_data.to_csv(
    "data/cleaned/costco_financials_cleaned.csv",
    index = False
)

print("\nCleaned financial data exported successfully.")