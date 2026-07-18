# SQL Analysis — HR Attrition Case Study

This document describes `IBM_Analytics_Query.sql`, containing all SQL queries used to analyze the IBM HR Analytics dataset in Google BigQuery for the HR Attrition Dashboard project.

- **Platform:** Google BigQuery (Standard SQL)
- **Source table:** `IBM_Dataset.IBM_Raw`
- **Total questions answered:** 19
- **Format:** Each section contains the business question, the SQL query, and a one-line insight based on the actual result

---

## How This File Is Structured

Every section follows the same pattern:

```sql
## [Do employees with lower monthly income leave more than higher earners?]
SELECT
    CASE
        WHEN MonthlyIncome < 5000 THEN 'Low Income'
        WHEN MonthlyIncome < 10000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Group,
    COUNT(*) AS Employees,
    COUNTIF(Attrition = TRUE) AS Attrition_Count,
    ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Income_Group
ORDER BY Attrition_Rate DESC;
...
## [Employee with low income has high attrition rate i.e 21.76 and employee with high income has low attrition rate.]
```

This mirrors how a Business Analyst documents findings for a stakeholder — question first, evidence second, takeaway last.

---

## Question Index

### 🟢 Descriptive — Understanding the Baseline

| # | Question | Key Finding |
|---|---|---|
| 1 | What is the overall attrition rate? | **16.12%** |
| 2 | How many employees left vs stayed? | 237 left, 1,233 stayed |
| 3 | Which department has the highest attrition? | Sales — **20.63%** |
| 4 | Which job role has the highest attrition? | Sales Representative — **39.76%** |
| 5 | Attrition rate by gender? | Male 2.21% higher than Female |
| 6 | Attrition rate by marital status? | Single — **25.53%** |
| 7 | Attrition rate by age group? | 17–30 age group highest |
| 8 | Attrition rate by business travel frequency? | Frequent travelers 24.91% vs Non-travelers 8% |

### 🟡 Diagnostic — Testing Attrition Drivers

| # | Question | Key Finding |
|---|---|---|
| 9 | Do overtime employees leave more? | Yes — significantly higher attrition |
| 10 | Relationship between distance from home and attrition? | Weak-to-moderate positive correlation (r = 0.32) |
| 11 | Do low-income employees leave more? | Yes — 21.76% vs lower rates for higher income |
| 12 | Job & environment satisfaction: left vs stayed? | Both notably lower among leavers |
| 13 | Do employees without recent promotions leave more? | Yes — no promotion in last 3 years shows highest attrition |
| 14 | Does stock option level affect attrition? | Yes — no stock options → higher attrition |
| 15 | Which combination of factors has highest attrition? | No stock option + low income + young + single |

### 🔴 Business Impact — Financial & Predictive Analysis

| # | Question | Key Finding |
|---|---|---|
| 16 | Estimated total annual cost of attrition? | ₹92,47,168 (approx.) |
| 17 | Cost of attrition by department? | Sales carries the highest cost |
| 18 | Which job roles carry the highest financial risk? | Ranked by cost, not just rate — highlights roles where rate and cost diverge |
| 19 | Preventable departures if overtime were reduced? | **~87 departures** could have been prevented |

### 🧠 Predictive Model

| Model | Description | Result |
|---|---|---|
| Employee Risk Score | Weighted score (0–4) based on Overtime, Low Income, No Stock Option, Frequent Travel — bucketed into Low / Medium / High Risk | **180 High Risk employees, 47.22% attrition rate** — nearly 8x the Low Risk baseline of 6.03% |

---

## Key Techniques Used

- **`COUNTIF` + `COUNT(*)`** for all rate and percentage calculations
- **`CASE WHEN`** for custom bucketing — age groups, income groups, promotion timelines, and the final risk categories
- **`CORR()`** for correlation analysis between Distance From Home and Attrition Rate
- **Common Table Expressions (CTEs)**, including nested multi-layer CTEs, for multi-step logic (e.g., the preventable-departures what-if model and the Risk Score model)
- **Correlated subqueries** to calculate group-specific attrition rates inline (used in the overtime what-if analysis)
- **`CAST(... AS INT64)`** for clean integer output on headcount figures
- **Multi-factor `GROUP BY`** for combination-risk analysis (Q15) and the final Risk Score model

---

## Data Handling Notes

- All rate calculations use `ROUND(..., 2)` for consistent decimal precision.
- Cost/currency figures also use 2-decimal rounding; headcount and departure figures are cast to whole integers, since fractional employees aren't meaningful.
- ⚠️ **Known inconsistency:** the age-group bucketing uses `17–30` as the youngest band in Question 7, but a different range (`20–30`) is used in the Question 15 combination-factor query. Both are internally consistent within their own query but do not match each other — worth standardizing if this file is extended further.
- The Employee Risk Score model was independently rebuilt in Power BI using DAX and cross-validated against this SQL output — both return identical results (180 / 477 / 813 employees across risk tiers), confirming the logic is correct in both environments.
- All queries are read-only (`SELECT` statements); the raw source table was never modified.

---

## Next Step

Following this analysis, the results were connected to **Power BI** for dashboard visualization — see the main project README for the full dashboard breakdown and business recommendations derived from these findings.

---

## Related Files

- `README.md` — full project overview, findings, and business recommendations
- `DATA_README.md` — data dictionary for the raw source dataset
- `IBM_Analytics_Query.sql` — the full query file this document describes
