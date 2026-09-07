/*
============================================================

Business Question:
How large is the customer churn problem?

Purpose:
Establish the overall churn baseline before analyzing which
customer segments and behaviors are associated with churn.

Key Metrics:
1. Total Customers
2. Churned Customers
3. Retained Customers
4. Churn Rate
5. Retention Rate

Analytical Principle:
Counts show the scale of churn, while rates make the result easier
to interpret and compare across future customer segments.
============================================================
*/


-- ============================================================
-- 1. OVERALL CHURN BASELINE
-- Business Question:
-- What percentage of customers churned versus remained retained?
-- ============================================================

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN churned = 0 THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct,
    ROUND(
        SUM(CASE WHEN churned = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS retention_rate_pct
FROM workspace.default.bronze_credit_card_customers;


/*
Observed Result:
Total Customers:    100,000
Churned Customers:  19,458
Retained Customers: 80,542
Churn Rate:          19.46%
Retention Rate:      80.54%

Interpretation:
The dataset has an overall churn rate of 19.46%, meaning nearly
1 in 5 customers churned.

This establishes a meaningful retention problem and provides the
baseline for deeper segmentation and behavioral analysis.

The next analytical question is not only how many customers churn,
but which customer groups and behaviors are most associated with churn.
*/


-- ============================================================
-- BASELINE SUMMARY
-- ============================================================

/*
Summary:

Approximately 19.46% of customers churned, while 80.54% were retained.

This baseline will be used as a reference point when evaluating
individual customer segments.
*/