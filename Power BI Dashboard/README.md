# Power BI Dashboard — HR Attrition Analytics

This document describes `IBM_HR_Analytics.pbix`, the interactive Power BI dashboard built on top of the SQL analysis in this project. It translates the findings from `IBM_Analytics_Query.sql` into a visual, stakeholder-facing report.

- **File:** `IBM_HR_Analytics.pbix`
- **Tool:** Power BI Desktop
- **Data source:** IBM HR Analytics dataset (originally analyzed in Google BigQuery, replicated in Power BI)
- **Pages:** 3
- **Theme:** Custom IBM-branded color scheme (Carbon Design–inspired), with a consistent Red / Yellow / Green severity system on risk-related visuals

---

## How to Open

1. Requires **Power BI Desktop** (free) — [download here](https://powerbi.microsoft.com/desktop/) if not already installed
2. Open `IBM_HR_Analytics.pbix` directly — no external data connection needed, as data is embedded in the file
3. If prompted to refresh data on open, click **Refresh** to ensure visuals reflect the latest calculated columns

---

## Dashboard Structure

### Page 1 — Executive Summary
A leadership-level overview of company-wide attrition metrics.

**Visuals included:**
- KPI cards: Cost of Attrition, Attrition Rate, Avg Salary Hike%, Total Attrition, Average Age, Employees Stayed
- Attrition Rate by OverTime (donut)
- Attrition Rate by Income Group (bar)
- Total Employee by Education Field (bar)
- Attrition Rate by Department (bar)
- Attrition Rate by Gender (donut)
- Attrition Rate by Job Role (horizontal bar)

**Purpose:** Answers "what is happening" at a glance — the entry point for anyone viewing the report for the first time.

---

### Page 2 — Risk Segments
A diagnostic deep-dive into the specific factors driving attrition.

**Visuals included:**
- KPI cards: Average Working Years, Average Work-Life Balance, Avg Monthly Income, Average Distance, Avg Environment Satisfaction, Avg Job Satisfaction
- Attrition Rate by Marital Status (donut)
- Job Role financial breakdown table — Total Employees, Employees Left, Avg Salary Hike%, Avg Monthly Income, Attrition Rate, **Total Attrition Cost** (sorted by Attrition Rate)
- Attrition Rate by Stock Group (bar)
- Attrition Rate by Income Group (bar)
- Attrition Rate by Business Travel (bar)

**Purpose:** Answers "why is it happening" — connects attrition drivers to real financial cost per role.

---

### Page 3 — Risk Score Model
The predictive centerpiece of the dashboard.

**Visuals included:**
- KPI cards: High Risk Employee count (180), High Risk Attrition Rate (47.22%), Low Risk Attrition Rate (6.03%)
- Attrition Rate by Risk Category (bar — Green/Yellow/Red coded)
- Total Employee by Risk Category (donut — Green/Yellow/Red coded)
- Job Role × Risk Category breakdown table (High/Medium/Low Risk employee counts plus overall attrition rate per role)

**Purpose:** Answers "who should HR act on first" — surfaces a specific, targetable 180-employee segment rather than leaving action items vague.

---

## Data Model Notes

**Calculated Columns (DAX):**
- `Risk Score` — sums 1 point each for: OverTime = Yes, MonthlyIncome < 5000, StockOptionLevel = 0, BusinessTravel = "Travel_Frequently"
- `Risk Category` — buckets `Risk Score` into Low Risk (0–1), Medium Risk (2), High Risk (3–4)

These were built independently in Power BI (not imported from SQL output) and validated to match the BigQuery Risk Score results exactly — 180 / 477 / 813 employees across High / Medium / Low Risk, with matching attrition rates.

**Key Measures:**
- Attrition Rate = `DIVIDE(COUNTROWS(FILTER(IBM_Dataset, IBM_Dataset[Attrition] = TRUE)), COUNTROWS(IBM_Dataset)) * 100`
- Total Attrition Cost = based on `COUNTIF(Attrition = true) × AVG(MonthlyIncome) × 6`, replicating the SQL cost model

---

## Navigation

The report includes a left-side navigation panel with **Page Navigator buttons** linking between all three pages (Executive Summary, Risk Segments, Risk Score Model). Navigation works in **Reading View** or **Presentation Mode** — actions do not trigger while in Edit View unless using Ctrl+Click.

---

## Design System

| Element | Color | Hex |
|---|---|---|
| Primary background | IBM Blue | `#0F62FE` |
| High Risk / Attrition | Red | `#DA1E28` |
| Medium Risk | Yellow | `#F1C21B` |
| Low Risk / Retained | Green | `#24A148` |
| Card accents | Light Blue | `#78A9FF` |
| Text | White / Light Gray | `#FFFFFF` / `#E0E0E0` |

A custom theme file (`IBM_Dark_Blue_Theme.json`) was used to apply this palette consistently across all visuals.

---

## Known Limitations

- This is a **static snapshot dashboard** — it does not auto-refresh from a live database connection; data was manually exported/replicated from the BigQuery analysis
- Slicers/filters are page-level; no cross-page filter persistence has been configured beyond default Power BI behavior
- Designed and tested at desktop resolution; mobile layout has not been separately optimized

---

## Related Files

- `README.md` — full project overview, findings, and business recommendations
- `SQL_README.md` — documentation of the underlying SQL analysis
- `DATA_README.md` — data dictionary for the raw source dataset
- `IBM_Dark_Blue_Theme.json` — custom Power BI theme file used in this dashboard
