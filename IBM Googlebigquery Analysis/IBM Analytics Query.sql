## Problem Statement: IBM is experiencing a 16.12% annual employee attrition rate, above the industry benchmark of ~10-15%.

## What is the overall attrition rate?
SELECT ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`;

## How many employees have left vs stayed in absolute numbers?
SELECT COUNTIF(Attrition = false) AS Employee_stayed,
       COUNTIF(Attrition = true) AS Employee_left
FROM `IBM_Dataset.IBM_Raw`;

## Which department has the highest attrition rate? 
SELECT Department, 
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Department
ORDER BY Attrition_Rate DESC;
## Sales Department has highest attrition rate that is 20.63%

## Which job role has the highest attrition? 
SELECT JobRole,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;
## Sales Representative job role has highest attrition rate i.e 39.76%

## What is the attrition rate by gender?
SELECT Gender,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Gender;
## Male Attrition Rate is higher compared to Female by 2.21%

## What is the attrition rate by marital status?
SELECT MaritalStatus,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY MaritalStatus
ORDER BY Attrition_Rate DESC;
## Single people has the highest Attrition rate i.e is 25.53%

## What is the attrition rate by age group? 
SELECT
    CASE
        WHEN Age BETWEEN 17 AND 30 THEN '17-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+'
    END AS Age_Group,
    ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Age_Group
ORDER BY Attrition_Rate DESC;
## The group of 17-30 has high attrition_rate 

## What is the attrition rate among employees who travel frequently vs rarely vs never?
SELECT BusinessTravel,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY BusinessTravel
ORDER BY Attrition_Rate DESC;
## Employee who travel frequently has high attrition rate and employee who not travel has lowest i.e 24.91% and 8% Respectively.

## Do employees who work overtime leave more than those who don't?
SELECT OverTime,
       COUNT(*) AS Total_Employee,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY OverTime
ORDER BY Attrition_Rate DESC;
## This confirms the fact that employee who work over time have hight attrition_rate.

## Is there a relationship between distance from home and attrition?
WITH table_2 AS (
  SELECT DistanceFromHome,
         ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
  FROM `IBM_Dataset.IBM_Raw`
  GROUP BY DistanceFromHome
)
SELECT ROUND(CORR(DistanceFromHome, Attrition_Rate),2) AS r
FROM table_2;
## Correlation analysis between Distance From Home and Attrition Rate produced r = 0.32, indicating a weak-to-moderate positive relationship. Employees with longer commutes show a slightly higher tendency to leave the organization, although other factors likely contribute more significantly to attrition.

## Do employees with lower monthly income leave more than higher earners?
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
## Employee with low income has high attrition rate i.e 21.76 and employee with high income has low attrition rate.

## How do job Average satisfaction scores compare between employees who left vs stayed?
SELECT CASE 
       WHEN Attrition = true THEN 'Employee left'
       WHEN Attrition = false THEN 'Employee stayed'
       END AS Employee_Group,
       ROUND(AVG(JobSatisfaction),2)AS AVG_Job_Satisfaction,
       ROUND(AVG(EnvironmentSatisfaction),2)AS AVG_Job_Satisfaction
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Employee_Group;

## Do employees who haven't been promoted recently leave more often?
SELECT CASE 
       WHEN YearsSinceLastPromotion BETWEEN 0 AND 3 THEN 'Promoted Recently'
       WHEN YearsSinceLastPromotion BETWEEN 4 AND 10 THEN 'More than 5 years less than 10'
       WHEN YearsSinceLastPromotion > 10 THEN 'More than 10 years'
       END AS promotion_group,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY promotion_group
ORDER BY Attrition_Rate DESC;
## No employee who have been promoted in last 3 years have highest attrition_rate.

## Does stock option level affect attrition — do employees with no stock options leave more?
SELECT CASE
       WHEN StockOptionLevel = 0 THEN 'No stock option'
       WHEN StockOptionLevel > 0 THEN 'Stock option'
       END AS Stock_group,
       COUNT(*) AS Total_Employee,
       COUNTIF(Attrition = true) AS Employee_left,
       ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Stock_group
ORDER BY Attrition_Rate DESC;
## its true that employee with no stock option have high attrition rate compared to who have.

## Which combination of factors has the highest attrition rate?
SELECT CASE
       WHEN StockOptionLevel = 0 THEN 'No stock option'
       WHEN StockOptionLevel > 0 THEN 'Stock option'
       END AS Stock_group,
       CASE
        WHEN MonthlyIncome < 5000 THEN 'Low Income'
        WHEN MonthlyIncome < 10000 THEN 'Medium Income'
        ELSE 'High Income'
        END AS Income_Group,
        CASE
        WHEN Age BETWEEN 20 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+'
        END AS Age_Group,
        MaritalStatus,
        ROUND(COUNTIF(Attrition = TRUE) * 100.0 / COUNT(*),2) AS Attrition_Rate
FROM `IBM_Dataset.IBM_Raw` 
GROUP BY Stock_group, Income_Group, Age_Group, MaritalStatus
ORDER BY Attrition_Rate DESC;

## What is the estimated total annual cost of attrition to IBM? (attrited employees × avg monthly income × 6)
WITH table_1 AS (
  SELECT COUNTIF(Attrition = true) AS employee_left,
         ROUND(AVG(MonthlyIncome),2) AS avg_monthly_income,
  FROM `IBM_Dataset.IBM_Raw`
)
SELECT (employee_left * avg_monthly_income * 6) AS Cost_of_Attrition 
FROM table_1;

## What is the cost of attrition broken down by department
SELECT
    Department,
    COUNTIF(Attrition = TRUE) AS Employees_Left,
    ROUND(AVG(MonthlyIncome),2) AS Avg_Monthly_Income,
    ROUND(COUNTIF(Attrition = TRUE) * AVG(MonthlyIncome) * 6, 2) AS Cost_of_Attrition
FROM `IBM_Dataset.IBM_Raw`
GROUP BY Department
ORDER BY Cost_of_Attrition DESC;

## Which job roles represent the highest financial attrition risk?
SELECT JobRole,
       ROUND(AVG(MonthlyIncome),2) AS Average_salary,
       ROUND(COUNTIF(Attrition = true)* 100 / COUNT(*),2) AS Attrition_rate,
       ROUND(COUNTIF(Attrition = true) * AVG(MonthlyIncome) * 6, 2) AS Cost_of_Attrition
FROM `IBM_Dataset.IBM_Raw`
GROUP BY JobRole
ORDER BY Attrition_rate DESC;

## If IBM reduced overtime for high-risk employees, how many potential departures could be prevented?
WITH table_1 AS (
                 SELECT COUNTIF(OverTime = true) AS Overtime_employee,
                        COUNTIF(OverTime = false) AS NonOvertime_employee,
                        (SELECT ROUND(COUNTIF(Attrition = true)/ COUNT(*),2) 
                          FROM `IBM_Dataset.IBM_Raw`
                          WHERE OverTime = true) AS Overtime_Attrition_Rate,
                        (SELECT ROUND(COUNTIF(Attrition = true)/ COUNT(*),2) 
                          FROM `IBM_Dataset.IBM_Raw`
                          WHERE OverTime = false) AS Non_Overtime_Attrition_Rate,
                 FROM `IBM_Dataset.IBM_Raw`
),
table_2 AS (
        SELECT 
        (Overtime_employee * Non_Overtime_Attrition_Rate) AS Expected_Departures,
        (Overtime_employee * Overtime_Attrition_Rate) AS Actual_Departures,
FROM table_1
)
SELECT CAST(Actual_Departures AS INT64) AS Actual_Departures,
       CAST(Expected_Departures AS INT64) AS Expected_Departures,
       CAST((Actual_Departures - Expected_Departures) AS INT64) AS Preventable_Departures
FROM table_2;
## If IBM had kept overtime employees' attrition rate at the same level as non-overtime employees, an estimated 87 departures could have been prevented — roughly two-thirds of all overtime-related attrition.
## Note:"This is a hypothetical estimate assuming overtime status is a direct driver of attrition. In practice, overtime may correlate with other factors like job role or department, so this should be read as an upper-bound estimate rather than a guaranteed reduction."

## Build an Employee Risk Score — categorize all current employees into Low / Medium / High attrition risk based on 3-4 key factors (overtime, income, satisfaction, years since promotion)
WITH risk_scored AS (
  SELECT
    EmployeeNumber,
    Attrition,
    OverTime,
    MonthlyIncome,
    StockOptionLevel,
    BusinessTravel,
    (
      CASE WHEN OverTime = true THEN 1 ELSE 0 END +
      CASE WHEN MonthlyIncome < 5000 THEN 1 ELSE 0 END +
      CASE WHEN StockOptionLevel = 0 THEN 1 ELSE 0 END +
      CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END
    ) AS Risk_Score
  FROM `IBM_Dataset.IBM_Raw`
),

risk_bucketed AS (
  SELECT
    *,
    CASE
      WHEN Risk_Score <= 1 THEN 'Low Risk'
      WHEN Risk_Score = 2 THEN 'Medium Risk'
      WHEN Risk_Score >= 3 THEN 'High Risk'
    END AS Risk_Category
  FROM risk_scored
)

SELECT
  Risk_Category,
  COUNT(*) AS Total_Employees,
  COUNTIF(Attrition = true) AS Employees_Left,
  ROUND(COUNTIF(Attrition = true) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM risk_bucketed
GROUP BY Risk_Category
ORDER BY Attrition_Rate DESC;

## Now lets connect database to power bi and move to visualization part.











