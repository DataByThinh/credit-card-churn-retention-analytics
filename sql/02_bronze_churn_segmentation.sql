/*
============================================================

Business Question:
Which customer segments have the highest churn rates?

Purpose:
Compare churn rates across customer profile, account, and payment
segments to identify groups that may require deeper investigation.


Analysis Sections:
1. Churn by Card Type
2. Churn by Employment Status
3. Churn by Account Tenure
4. Churn by Late Payment Amount
5. Churn by Age Group
6. Churn by Income Band

Analytical Principle:
Use churn rate, not only churned customer count, when comparing
segments of different sizes.
============================================================
*/


-- ============================================================
-- 1. CHURN BY CARD TYPE
-- Business Question:
-- Do customers with different card types have different churn rates?
-- ============================================================

SELECT
    card_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM workspace.default.bronze_credit_card_customers
GROUP BY card_type
ORDER BY churn_rate_pct DESC;


/*
Observed Result:
Standard: 19.64%
Silver:   19.43%
Gold:     19.25%
Platinum: 18.92%

Interpretation:
Churn rates are relatively similar across card types.
Card type alone does not appear to strongly differentiate churn behavior.
*/


-- ============================================================
-- 2. CHURN BY EMPLOYMENT STATUS
-- Business Question:
-- Do employment groups have meaningfully different churn rates?
-- ============================================================

SELECT
    employment_status,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM workspace.default.bronze_credit_card_customers
GROUP BY employment_status
ORDER BY churn_rate_pct DESC;


/*
Observed Result:
Students and unemployed customers were around 20% churn,
while employed, self-employed, and retired customers were around 19%.

Interpretation:
Employment status shows only small differences in churn rate.
It does not appear to be a strong churn discriminator by itself.
*/


-- ============================================================
-- 3. CHURN BY ACCOUNT TENURE
-- Business Question:
-- Does customer tenure affect churn behavior?
-- ============================================================

WITH customer_tenure AS (
    SELECT
        customer_id,
        churned,
        account_age_months,
        CASE
            WHEN account_age_months <= 12 THEN '0-12 months'
            WHEN account_age_months <= 24 THEN '13-24 months'
            WHEN account_age_months <= 36 THEN '25-36 months'
            WHEN account_age_months <= 60 THEN '37-60 months'
            ELSE '61+ months'
        END AS tenure_group
    FROM workspace.default.bronze_credit_card_customers
)

SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM customer_tenure
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;


/*
Observed Result:
Tenure groups showed relatively similar churn rates,
generally around 18%-20%.

Interpretation:
Account tenure alone does not appear to explain a major difference
in churn behavior.
*/


-- ============================================================
-- 4. CHURN BY LATE PAYMENT AMOUNT
-- Business Question:
-- Do customers with higher late payment amounts have higher churn rates?
-- ============================================================

WITH payment_band AS (
    SELECT
        churned,
        late_payment_amount,
        CASE
            WHEN late_payment_amount = 0 THEN 'No late payment'
            WHEN late_payment_amount <= 20 THEN '$0.01-$20'
            WHEN late_payment_amount <= 50 THEN '$20.01-$50'
            WHEN late_payment_amount <= 100 THEN '$50.01-$100'
            ELSE '$100+'
        END AS late_payment_band
    FROM workspace.default.bronze_credit_card_customers
)

SELECT
    late_payment_band,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM payment_band
GROUP BY late_payment_band
ORDER BY churn_rate_pct DESC;


/*
Observed Result:
No late payment: 12.46%
$0.01-$20:       31.38%
$20.01-$50:      33.97%
$50.01-$100:     35.61%
$100+:           45.67%

Interpretation:
Late payment amount shows a much stronger churn pattern than
card type, employment status, or tenure.

Customers with no late payments have substantially lower churn,
while churn rate increases as late payment amount rises.

Important:
This shows association, not proof that late payment causes churn.
*/


-- ============================================================
-- 5. CHURN BY AGE GROUP
-- Business Question:
-- Do customers in different age groups have different churn rates?
-- ============================================================

WITH age_segment AS (
    SELECT
        churned,
        age,
        CASE
            WHEN age < 25 THEN 'Under 25'
            WHEN age <= 34 THEN '25-34'
            WHEN age <= 44 THEN '35-44'
            WHEN age <= 54 THEN '45-54'
            WHEN age <= 64 THEN '55-64'
            ELSE '65+'
        END AS age_group
    FROM workspace.default.bronze_credit_card_customers
)

SELECT
    age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM age_segment
GROUP BY age_group
ORDER BY churn_rate_pct DESC;


/*
Interpretation:
Compare churn rates across age groups to determine whether churn
is concentrated among younger, middle-aged, or older customers.

Add the observed result here after running the query.
*/


-- ============================================================
-- 6. CHURN BY INCOME BAND
-- Business Question:
-- Do customers with different income levels have different churn rates?
-- ============================================================

WITH income_segment AS (
    SELECT
        churned,
        income,
        CASE
            WHEN income < 30000 THEN 'Under $30K'
            WHEN income < 50000 THEN '$30K-$49K'
            WHEN income < 75000 THEN '$50K-$74K'
            WHEN income < 100000 THEN '$75K-$99K'
            WHEN income < 150000 THEN '$100K-$149K'
            ELSE '$150K+'
        END AS income_band
    FROM workspace.default.bronze_credit_card_customers
)

SELECT
    income_band,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct
FROM income_segment
GROUP BY income_band
ORDER BY churn_rate_pct DESC;


/*
Interpretation:
Compare churn rates across income groups to determine whether
income level is associated with meaningfully different churn behavior.

Add the observed result here after running the query.
*/


-- ============================================================
-- SEGMENTATION SUMMARY
-- ============================================================

/*
Summary:

Initial segmentation indicates that broad profile and account
characteristics such as card type, employment status, and tenure
show relatively small churn differences.

Late payment amount shows a much clearer churn pattern, suggesting
that payment behavior may be more informative than basic customer
profile characteristics.

Next Step:
Continue investigating customer behavior and engagement variables
to identify stronger churn signals.
*/

