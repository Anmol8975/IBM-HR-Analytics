# Case Study: Reducing Employee Attrition Through Data-Driven Risk Segmentation
### An HR Analytics Case Study | IBM Employee Dataset

---

## Executive Summary

IBM was experiencing an employee attrition rate of **16.12%** — above the industry benchmark of 10–15% — costing an estimated **₹92.47 lakhs annually**. This case study walks through how workforce data was used to diagnose the root causes of attrition, build a predictive risk-scoring model, and translate findings into a prioritized action plan for HR leadership.

The result: a **180-employee High Risk segment was identified with a 47.22% attrition rate — nearly 8x the baseline** — giving HR a specific, targetable group to focus retention efforts on, instead of spreading resources across the entire 1,470-person workforce.

---

## 1. The Situation

IBM's HR leadership had visibility into *that* attrition was above benchmark, but not *why*, *who*, or *what to do about it*. Existing reporting showed high-level turnover numbers but offered no way to prioritize interventions or estimate financial impact.

**The ask:** Analyze workforce data to answer three questions —
1. Who is leaving?
2. Why are they leaving?
3. What should HR do about it?

---

## 2. The Approach

The analysis was structured in three phases, moving from descriptive to diagnostic to predictive — the same progression a Business Analyst would use in a real workplace engagement.

### Phase 1 — Descriptive Analysis
Established the baseline. Using SQL in Google BigQuery, attrition rates were broken down across every major employee dimension: department, job role, gender, age, marital status, and travel frequency.

**Key output:** Sales Representatives had the highest attrition rate of any role at **39.76%**, and the Sales department led all departments at **20.63%**.

### Phase 2 — Diagnostic Analysis
Moved from *what* to *why*. Tested relationships between attrition and controllable business factors: overtime, income, satisfaction scores, promotion history, and stock option allocation.

**Key output:** Employees working overtime, earning below ₹5,000/month, or holding no stock options showed consistently and substantially higher attrition rates than their peers.

### Phase 3 — Predictive Modeling
Combined the strongest diagnostic signals into a single, weighted **Risk Score** — built first in SQL, then replicated natively in Power BI using DAX, and validated by confirming both outputs matched exactly.

Each employee received one point per risk factor present:
- Works overtime
- Monthly income below ₹5,000
- No stock option allocation
- Travels frequently for business

Employees were then segmented into **Low / Medium / High Risk** based on their total score.

---

## 3. The Financial Case

Beyond identifying *who* was at risk, the analysis quantified *what it was costing*:

| Metric | Value |
|---|---|
| Total Annual Cost of Attrition | ₹92,47,168 |
| Highest-Cost Department | Sales |
| Estimated Preventable Departures (overtime reduction) | 87 |

This reframed the problem from an HR metric into a financial one — critical for getting leadership buy-in on any proposed intervention.

---

## 4. The Result: A Working Risk Model

The Risk Score model was validated by checking whether attrition rate climbed cleanly across risk tiers — a sign the model was capturing a real signal rather than noise.

| Risk Category | Employees | % of Workforce | Attrition Rate |
|---|---|---|---|
| Low Risk | 813 | 55.3% | 6.03% |
| Medium Risk | 477 | 32.5% | 21.59% |
| **High Risk** | **180** | **12.2%** | **47.22%** |

The nearly **8x gap** between the Low Risk and High Risk groups confirmed the model's validity and gave HR a concrete, prioritized starting point: a group representing just 12% of the workforce, responsible for a disproportionate share of total departures.

---

## 5. From Analysis to Action

The final phase translated every finding into a specific, prioritized recommendation — the step that separates a data analysis from a business case.

**Recommendation 1 — Target the High Risk Segment**
Focus retention resources on the 180 identified employees rather than diluting budget across a company-wide program.

**Recommendation 2 — Address Overtime Load in Sales**
Audit territory and workload distribution; modeling suggests up to 87 departures could have been prevented.

**Recommendation 3 — Rank Interventions by Financial Impact, Not Just Rate**
The highest attrition *rate* does not always mean the highest attrition *cost* — HR should prioritize using the financial breakdown, not percentages alone.

**Recommendation 4 — Expand Stock Option Eligibility Earlier**
Close the gap for employees in lower income brackets who currently receive no equity allocation.

**Recommendation 5 — Treat Demographic Patterns as Symptoms, Not Levers**
Age and marital status differences likely reflect underlying tenure and income patterns rather than being independently actionable — policy should address the root drivers instead.

---

## 6. Delivery: The Dashboard

Findings were delivered through a 3-page interactive Power BI dashboard, designed for two different audiences:

- **Executive Summary** — a leadership-level overview of company-wide attrition KPIs
- **Risk Segments** — a diagnostic view for HR analysts to explore attrition drivers in depth
- **Risk Score Model** — the predictive centerpiece, giving HR a direct answer to "who should we act on first?"

A consistent Red / Yellow / Green severity color system was applied across all risk-related visuals, so risk level is legible at a glance without needing to read every label.

---

## 7. Limitations & Next Steps

This analysis is **correlational, not causal**, and based on a single historical snapshot rather than longitudinal data. The recommended next step is a **controlled pilot**: apply the High Risk retention intervention to a subset of the identified 180 employees for one quarter, then measure whether their attrition rate declines relative to a control group before scaling the approach company-wide.

---

## Tools & Methods

`SQL (Google BigQuery)` · `Power BI` · `DAX` · `Correlation Analysis` · `Weighted Risk Scoring` · `Financial Impact Modeling`

---

## About This Project

This case study was built as an independent portfolio project using the publicly available IBM HR Analytics Employee Attrition dataset, structured to mirror a real-world Business Analyst engagement — from problem framing through to a delivered, decision-ready dashboard.

Dataset

IBM HR Analytics Employee Attrition & Performance — publicly available on Kaggle, 1,470 employee records across 35 attributes.

---
### Author

Anmol Verma
Aspiring Business Analyst | SQL · Power BI · Data Storytelling

I build end-to-end analytics case studies that go from raw data to business recommendations — not just dashboards, but the reasoning behind them. This project reflects how I approach a business problem: define it clearly, diagnose it with data, quantify its cost, and turn findings into decisions someone can actually act on.


📍 New Delhi, India

📧 manojaashp.anm@gmail.com

💼 LinkedIn — https://www.linkedin.com/in/anmol-verma-2810a2369/


### Other projects:


* Adventure Works Sales Analytics — end-to-end BI project analyzing $24.9M in retail data using a custom ETL pipeline and star schema in Google BigQuery
* Bank Customer Churn — retention risk and customer analytics project
