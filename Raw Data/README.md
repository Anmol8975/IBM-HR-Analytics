# Dataset: IBM HR Analytics Employee Attrition

## Overview

This is the raw, unmodified dataset used as the source of truth for the [HR Analytics Attrition Dashboard](../README.md) project. It contains anonymized employee records from a fictional IBM dataset, commonly used for HR analytics and attrition modeling practice.

- **File name:** `WA_Fn-UseC_-HR-Employee-Attrition.csv`
- **Rows:** 1,470 employees
- **Columns:** 35 attributes
- **Format:** CSV (UTF-8, comma-delimited)
- **Source:** [Kaggle — IBM HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
- **License:** Public dataset, released for educational and analytical use

---

## Data Dictionary

| Column | Type | Description |
|---|---|---|
| Age | Integer | Employee age in years |
| Attrition | Boolean (Yes/No) | Whether the employee has left the company |
| BusinessTravel | Text | Travel frequency: Non-Travel, Travel_Rarely, Travel_Frequently |
| DailyRate | Integer | Daily pay rate |
| Department | Text | Department: Sales, Research & Development, Human Resources |
| DistanceFromHome | Integer | Distance from home to workplace (in km/miles) |
| Education | Integer (1–5) | Education level: 1=Below College, 2=College, 3=Bachelor, 4=Master, 5=Doctor |
| EducationField | Text | Field of study |
| EmployeeCount | Integer | Constant value (1) for all rows |
| EmployeeNumber | Integer | Unique employee identifier |
| EnvironmentSatisfaction | Integer (1–4) | Satisfaction with work environment |
| Gender | Text | Male / Female |
| HourlyRate | Integer | Hourly pay rate |
| JobInvolvement | Integer (1–4) | Level of job involvement |
| JobLevel | Integer (1–5) | Seniority level within the company |
| JobRole | Text | Specific job title |
| JobSatisfaction | Integer (1–4) | Satisfaction with current job |
| MaritalStatus | Text | Single, Married, Divorced |
| MonthlyIncome | Integer | Monthly salary |
| MonthlyRate | Integer | Monthly pay rate (separate from income) |
| NumCompaniesWorked | Integer | Number of companies worked at previously |
| Over18 | Text | Whether employee is over 18 (constant: Y) |
| OverTime | Boolean (Yes/No) | Whether employee regularly works overtime |
| PercentSalaryHike | Integer | Percentage salary increase in the last review |
| PerformanceRating | Integer (1–4) | Most recent performance rating |
| RelationshipSatisfaction | Integer (1–4) | Satisfaction with workplace relationships |
| StandardHours | Integer | Standard working hours (constant: 80) |
| StockOptionLevel | Integer (0–3) | Level of stock option ownership |
| TotalWorkingYears | Integer | Total years of professional work experience |
| TrainingTimesLastYear | Integer | Number of trainings attended last year |
| WorkLifeBalance | Integer (1–4) | Self-reported work-life balance rating |
| YearsAtCompany | Integer | Tenure at current company |
| YearsInCurrentRole | Integer | Years spent in current role |
| YearsSinceLastPromotion | Integer | Years since last promotion |
| YearsWithCurrManager | Integer | Years working under current manager |

---

## Known Data Notes

- `EmployeeCount`, `Over18`, and `StandardHours` are constant across all rows and carry no analytical value — safe to exclude from analysis.
- No missing/null values are present in the original dataset.
- `Attrition` and `OverTime` are stored as text (`"Yes"`/`"No"`) in the raw CSV; confirm data type after import, as some tools (e.g., BigQuery) may cast these as boolean automatically.
- This is a **static, single-snapshot dataset** — it does not track attrition over time, so all findings derived from it are correlational, not longitudinal or causal.

---

## Usage in This Project

This raw file was loaded into **Google BigQuery** (`IBM_Dataset.IBM_Raw`) without modification. All cleaning, bucketing (e.g., age groups, income groups), and derived fields (e.g., Risk Score) were handled downstream via SQL and DAX — the raw file itself was never altered, to preserve a single source of truth.

