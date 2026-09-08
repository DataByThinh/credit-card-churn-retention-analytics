/*
================================================================
Financial Stress Analysis
Business Question:
How does financial stress impact customer churn behavior?

================================================================
Purpose: 
Analyze the relationship between financial stress levels and customer churn behavior to inform targeted retention strategies.
*/ 

WITH financial_stress_band AS (

    SELECT
        churned,

        CASE
            WHEN financial_stress_score < 30 THEN 'LOW'
            WHEN financial_stress_score BETWEEN 30 AND 60 THEN 'MEDIUM'
            ELSE 'HIGH'
        END AS financial_stress_level

    FROM workspace.default.bronze_credit_card_customers
)

SELECT

    CASE
        WHEN financial_stress_level = 'LOW' THEN 'Under 30'
        WHEN financial_stress_level = 'MEDIUM' THEN '30-60'
        WHEN financial_stress_level = 'HIGH' THEN 'Above 60'
    END AS score_range,

    financial_stress_level,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct

FROM financial_stress_band

GROUP BY financial_stress_level

ORDER BY
    CASE
        WHEN financial_stress_level = 'LOW' THEN 1
        WHEN financial_stress_level = 'MEDIUM' THEN 2
        WHEN financial_stress_level = 'HIGH' THEN 3
    END;

/* 
============================================================
Results: 
The analysis categorizes customers into three financial stress levels: LOW, MEDIUM, and HIGH.
Low stress: 61,083 customers, with an 11.39% churn rate
Medium stress: 35,149 customers, with a 27.96% churn rate
High stress: 3,768 customers, with a 70.97% churn rate 

Interpretation:
Customers with higher financial stress levels exhibit significantly higher churn rates. This suggests that targeted interventions for customers in the HIGH stress category could improve retention outcomes.
============================================================
*/

/* 
============================================================
Customers Engagement Analysis
Business Question:
Do customers with lower engagement have a higher churn rate?

Purpose:
Compare churn rates across Low, Medium, and High engagement groups to understand whether customer engagement is associated with churn.
============================================================
*/

WITH engagement_band AS (

    SELECT
        churned,

        CASE
            WHEN engagement_score < 30 THEN 'LOW'
            WHEN engagement_score BETWEEN 30 AND 60 THEN 'MEDIUM'
            ELSE 'HIGH'
        END AS engagement_level

    FROM workspace.default.bronze_credit_card_customers
)

SELECT

    CASE
        WHEN engagement_level = 'LOW' THEN 'Under 30'
        WHEN engagement_level = 'MEDIUM' THEN '30-60'
        WHEN engagement_level = 'HIGH' THEN 'Above 60'
    END AS score_range,

    engagement_level,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct

FROM engagement_band

GROUP BY engagement_level

ORDER BY
    CASE
        WHEN engagement_level = 'LOW' THEN 1
        WHEN engagement_level = 'MEDIUM' THEN 2
        WHEN engagement_level = 'HIGH' THEN 3
    END;

/*
============================================================
Results:

Low engagement: 597 customers, with a 42.71% churn rate
Medium engagement: 38,190 customers, with a 27.96% churn rate
High engagement: 61,213 customers, with a 13.93% churn rate

Interpretation:
Churn rate decreases as engagement increases, suggesting that lower-engagement customers are more likely to churn.
============================================================
*/

/* 
============================================================
Customers Payment Delays Analysis
Business Question:
Do customers with more payment delays have a higher churn rate?
Purpose:
Compare churn rates across Low, Medium, and High payment delay groups to understand whether payment behavior is associated with churn.
============================================================
 */

WITH payment_delay_band AS (

    SELECT
        churned,

        CASE
            WHEN payment_delay_count = 0 THEN 'NO DELAY'
            WHEN payment_delay_count BETWEEN 1 AND 2 THEN 'LOW'
            WHEN payment_delay_count BETWEEN 3 AND 5 THEN 'MEDIUM'
            ELSE 'HIGH'
        END AS payment_delay_level

    FROM workspace.default.bronze_credit_card_customers
)

SELECT

    CASE
        WHEN payment_delay_level = 'NO DELAY' THEN '0 delay'
        WHEN payment_delay_level = 'LOW' THEN '1-2 delays'
        WHEN payment_delay_level = 'MEDIUM' THEN '3-5 delays'
        WHEN payment_delay_level = 'HIGH' THEN '6+ delays'
    END AS delay_range,

    payment_delay_level,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_pct

FROM payment_delay_band

GROUP BY payment_delay_level

ORDER BY
    CASE
        WHEN payment_delay_level = 'NO DELAY' THEN 1
        WHEN payment_delay_level = 'LOW' THEN 2
        WHEN payment_delay_level = 'MEDIUM' THEN 3
        WHEN payment_delay_level = 'HIGH' THEN 4
    END;

/*
============================================================
Results:
0 delays: 70,059 customers, 12.46% churn rate
1–2 delays: 27,281 customers, 31.92% churn rate
3–5 delays: 2,599 customers, 75.49% churn rate
6+ delays: 61 customers, 98.36% churn rate

Interpretation:
Churn rises sharply as payment delays increase, suggesting that repeated payment delays are strongly associated with customer churn.
============================================================
*/  