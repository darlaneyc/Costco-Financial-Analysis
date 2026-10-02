-- Costco Financial Operations & Performance Analysis
-- SQL Analysis
-- Fiscal Years: 2021-2025
--
-- Purpose:
-- Analyze Costco's revenue growth, profitability,
-- operating costs, and financial position.

-- 1. Revenue and profitability trends by fiscal year
-- How has Costco's revenue growth and profitability changed from 2021-2025?

SELECT
    fiscal_year,
    total_revenue,
    revenue_growth_pct,
    operating_margin_pct,
    net_profit_margin_pct
FROM costco_financials
ORDER BY fiscal_year;

-- 2. Operating cost structure and profitability
-- What happened to Costco's operating cost structure as its operating margin changed?

SELECT
    fiscal_year,
    merchandise_cost_ratio_pct,
    sga_ratio_pct,
    operating_margin_pct
FROM costco_financials
ORDER BY fiscal_year;

-- Compare operating cost ratios between 2023 and 2025

SELECT
    ROUND(y2025.merchandise_cost_ratio_pct -
          y2023.merchandise_cost_ratio_pct, 2)
          AS merchandise_cost_change_pp,

    ROUND(y2025.sga_ratio_pct -
          y2023.sga_ratio_pct, 2)
          AS sga_change_pp,

    ROUND(y2025.operating_margin_pct -
          y2023.operating_margin_pct, 2)
          AS operating_margin_change_pp

FROM costco_financials AS y2025
JOIN costco_financials AS y2023
WHERE y2025.fiscal_year = 2025
  AND y2023.fiscal_year = 2023;

-- 3. Membership fee growth and revenue contribution
-- How have Costco's membership fees grown, and how important are they as a share of total revenue?

SELECT
    fiscal_year,
    membership_fees,
    membership_fee_growth_pct,
    membership_fee_revenue_share_pct
FROM costco_financials
ORDER BY fiscal_year;

-- Compare membership fee growth with total revenue growth

SELECT
    fiscal_year,
    revenue_growth_pct,
    membership_fee_growth_pct,
    ROUND(
        membership_fee_growth_pct - revenue_growth_pct,
        2
    ) AS growth_difference_pp
FROM costco_financials
WHERE fiscal_year > 2021
ORDER BY fiscal_year;

-- 4. Liquidity and long-term debt trends
-- How has Costco's ability to cover short-term obligations and its reliance on long-term debt changed from 2021-2025

SELECT
    fiscal_year,
    total_current_assets,
    total_current_liabilities,
    current_ratio,
    long_term_debt,
    stockholders_equity,
    long_term_debt_to_equity_ratio
FROM costco_financials
ORDER BY fiscal_year;

-- Compare long-term debt-to-equity between 2021 and 2025

SELECT
    ROUND(
        y2025.long_term_debt_to_equity_ratio -
        y2021.long_term_debt_to_equity_ratio,
        2
    ) AS debt_to_equity_change
FROM costco_financials AS y2025
JOIN costco_financials AS y2021
WHERE y2025.fiscal_year = 2025
  AND y2021.fiscal_year = 2021;

  -- 5. Executive financial performance summary
  -- What are the key financial and operating KPIs for each fiscal year?

SELECT
    fiscal_year,
    total_revenue,
    revenue_growth_pct,
    operating_margin_pct,
    net_profit_margin_pct,
    membership_fee_growth_pct,
    current_ratio,
    long_term_debt_to_equity_ratio
FROM costco_financials
ORDER BY fiscal_year;

-- Compare key metrics from 2021 to 2025

SELECT
    ROUND(
        (y2025.total_revenue - y2021.total_revenue)
        * 100.0 / y2021.total_revenue,
        2
    ) AS total_revenue_growth_pct,

    ROUND(
        y2025.operating_margin_pct -
        y2021.operating_margin_pct,
        2
    ) AS operating_margin_change_pp,

    ROUND(
        y2025.net_profit_margin_pct -
        y2021.net_profit_margin_pct,
        2
    ) AS net_profit_margin_change_pp,

    ROUND(
        y2025.long_term_debt_to_equity_ratio -
        y2021.long_term_debt_to_equity_ratio,
        2
    ) AS debt_to_equity_change

FROM costco_financials AS y2025
JOIN costco_financials AS y2021
WHERE y2025.fiscal_year = 2025
  AND y2021.fiscal_year = 2021;