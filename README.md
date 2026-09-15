# 💳 Credit Card Churn & Retention Analytics

<p align="center">
  <img src="https://img.shields.io/badge/Databricks-Lakehouse-FF3621?style=for-the-badge&logo=databricks&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL-Analytics-4479A1?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Delta%20Lake-Data%20Pipeline-00ADD8?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Python-ML-3776AB?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/Power%20BI-Business%20Intelligence-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" />
  <img src="https://img.shields.io/badge/XGBoost-Churn%20Prediction-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/SHAP-Explainable%20AI-8A2BE2?style=for-the-badge" />
</p>

<p align="center">
  <strong>From Customer Behavior → Churn Risk → Retention Action</strong><br>
  End-to-end customer churn analytics for consumer banking.
</p>

<p align="center">
  <img src="" width="100%" />
</p>

> **Which customers are leaving, why are they leaving, and who should the bank retain first?**
>
> This project transforms **100K+ credit card customer records** into churn insights, predictive risk scores, and retention opportunities using Databricks, SQL, machine learning, and Power BI.

---

## 🎯 What This System Answers

|    | Business Question                             |
| -- | --------------------------------------------- |
| 📉 | **Who is churning?**                          |
| 🔍 | **What behaviors are associated with churn?** |
| 🤖 | **Who is most likely to churn next?**         |
| 💰 | **How much customer value is at risk?**       |
| 🎯 | **Who should be prioritized for retention?**  |

---

## 🏗️ Architecture

<p align="center">
  <img src="https://github.com/DataByThinh/credit-card-churn-retention-analytics/blob/main/picture/architecture.png?raw=true" width="100%" />
</p>

---

## 🥉 → 🥈 → 🥇 Data Pipeline

<p align="center">
  <img src="assets/medallion-pipeline.png" width="90%" />
</p>

| Layer         | Purpose                                      |
| ------------- | -------------------------------------------- |
| 🥉 **Bronze** | Raw customer data                            |
| 🥈 **Silver** | Cleaned + standardized + behavioral features |
| 🥇 **Gold**   | Analytics, ML, and BI-ready datasets         |

### Core Analytics Features

`Financial Stress` • `Engagement` • `Utilization` • `Complaints` • `Tenure` • `Payment Behavior` • `Customer Value`

---

## 🔍 Customer Churn Analytics

<p align="center">
  <img src="assets/churn-segmentation.png" width="100%" />
</p>

Customer behavior is segmented across:

```text
Customer
   │
   ├── Demographics
   ├── Account Tenure
   ├── Card Type
   ├── Financial Stress
   ├── Engagement
   ├── Utilization
   ├── Complaints
   └── Support Satisfaction
             ↓
        Churn Patterns
```

---

## 🤖 Predictive Churn Modeling

<p align="center">
  <img src="assets/ml-pipeline.png" width="90%" />
</p>

```text
Customer Features
       ↓
Feature Engineering
       ↓
Logistic Regression
       ↓
XGBoost / Random Forest
       ↓
Churn Probability
       ↓
SHAP Explainability
       ↓
Retention Priority
```

### Model Evaluation

`Precision` • `Recall` • `F1` • `ROC-AUC` • `PR-AUC`

> Target leakage variables are excluded from model training.

---

## 🧠 Explainable AI

<p align="center">
  <img src="assets/shap-drivers.png" width="100%" />
</p>

SHAP connects model predictions back to business behavior:

**What increases churn risk?**

`Low Engagement` → `Financial Stress` → `Complaints` → `Payment Behavior` → `Utilization` → `Product Usage`

---

## 🎯 Retention Intelligence

<p align="center">
  <img src="assets/retention-priority.png" width="90%" />
</p>

```text
High Churn Risk
      +
High Customer Value
      ↓
🚨 Critical Retention Priority
```

| Risk      | Customer Value | Action                |
| --------- | -------------- | --------------------- |
| 🔴 High   | 💰 High        | **Retain First**      |
| 🟠 High   | Medium         | Targeted Intervention |
| 🟡 Medium | High           | Monitor               |
| 🟢 Low    | High           | Maintain Engagement   |

---

## 📊 Power BI Dashboard

<p align="center">
  <img src="assets/powerbi-dashboard.png" width="100%" />
</p>

### Dashboard Views

**01 — Executive Overview**
Churn rate • Retention rate • Customer value at risk

**02 — Churn Drivers**
Tenure • Engagement • Complaints • Payment behavior • Product usage

**03 — Predictive Churn**
Risk segments • Churn probability • Model performance • SHAP drivers

**04 — Retention Opportunity**
High-value customers at risk • Retention priorities • What-if scenarios

---

## 💰 What-If Retention Analysis

<p align="center">
  <img src="assets/what-if-retention.png" width="90%" />
</p>

```text
Reduce Churn
   ↓
1%   3%   5%   10%
   ↓
Customers Retained
   ↓
Customer Value Preserved
```

> **What happens if churn among high-value customers falls by 5%?**

---

## 📁 Project Structure

```text
credit-card-churn-retention-analytics/
│
├── README.md
├── assets/
│   ├── project-overview.png
│   ├── churn-architecture.png
│   ├── medallion-pipeline.png
│   ├── ml-pipeline.png
│   └── powerbi-dashboard.png
│
├── data/
│   └── credit_card_customer_churn_dataset.csv
│
├── sql/
│   ├── churn_baseline.sql
│   ├── churn_segmentation.sql
│   └── churn_drivers.sql
│
├── dbt/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
│
├── notebooks/
│   ├── data_quality/
│   ├── feature_engineering/
│   └── machine_learning/
│
├── models/
│   └── churn_model/
│
├── powerbi/
│   └── churn_retention_dashboard.pbix
│
└── requirements.txt
```

---

## ⚙️ Tech Stack

<p align="center">

**Databricks** · **Delta Lake** · **SQL** · **dbt** · **Python** · **scikit-learn** · **XGBoost** · **SHAP** · **Power BI**

</p>

---

## 👤 Author

**Thinh Nguyen**

Data Analytics • Analytics Engineering • Data Science

---

<div align="center">

### 💳 Turn churn signals into retention decisions.

**Built with data, SQL, machine learning, and a lot of customer segmentation.**

</div>
