CREATE DATABASE CREDIT_CARD;

# Import data from excel file into sql using import wizard. Change the datatype to appropriate datatype
# What are the columns present ? 
USE CREDIT_CARD;
SELECT *
FROM credit_card;

# What is the overall approval rate 
SELECT
ROUND(SUM(CASE WHEN Approved = 1 THEN 1 ELSE 0 END)/COUNT(Approved) * 100,2) AS credit_card_approved,
ROUND(SUM(CASE WHEN Approved = 0 THEN 1 ELSE 0
END)/ COUNT(Approved) * 100, 2) AS credit_card_declined
FROM credit_card;

# How does the aproval rate vary by age and if they are employed

With Age_group_table AS(
SELECT TIMESTAMPDIFF(YEAR,DATE_ADD(current_date(),INTERVAL birthday_count DAY),Current_date()) AS age,
CASE 
WHEN TIMESTAMPDIFF(YEAR,DATE_ADD(current_date(),INTERVAL birthday_count DAY),Current_date()) BETWEEN 18 AND 24 THEN 'Young_adult'
WHEN TIMESTAMPDIFF(YEAR,DATE_ADD(current_date(),INTERVAL birthday_count DAY),Current_date()) BETWEEN 25 AND 44 THEN 'adult'
WHEN TIMESTAMPDIFF(YEAR,DATE_ADD(current_date(),INTERVAL birthday_count DAY),Current_date()) BETWEEN 45 AND 64 THEN 'Middle_age_adult'
ELSE 'Senior' 
END AS Age_group, approved, Employed_days
FROM credit_card
ORDER BY 1
)

SELECT age_group,CASE
WHEN Employed_days LIKE '%-%' THEN 'Employed'
ELSE 'Unemployed' END AS Employment_class,
ROUND(100 * (SUM(CASE WHEN Approved = 1 THEN 1 ELSE 0 
END))/ COUNT(*),2) AS approved_percentage_total, ROUND(100 * (SUM(CASE WHEN Approved = 0 THEN 1 ELSE 0 
END))/ COUNT(*),2) AS decline_percentage_total 
FROM age_group_table
GROUP BY 1,2
ORDER BY 1;

# How does approval rate vary by gender and marital status
SELECT Gender, marital_status, ROUND(100 * (SUM(CASE WHEN Approved = 1 THEN 1 ELSE 0 
END))/ COUNT(*),2) AS approved_percentage_total, ROUND(100 * (SUM(CASE WHEN Approved = 0 THEN 1 ELSE 0 
END))/ COUNT(*),2) AS decline_percentage_total 
FROM credit_card
WHERE Gender <> ''
GROUP BY 1, 2
ORDER BY 2, 1;

# How does approval rate vary by income 
With income_table AS (SELECT 
CASE 
WHEN Annual_income BETWEEN 30000 AND 60000 THEN '30,000 - 60,000'
WHEN Annual_income BETWEEN 60000 AND 100000 THEN '60,000 - 100,000'
WHEN Annual_income BETWEEN 100000 AND 200000 THEN '100,000 - 200,000'
WHEN Annual_income BETWEEN 200000 AND 300000 THEN '200,000 - 300,000'
WHEN Annual_income BETWEEN 300000 AND 400000 THEN '300,000 - 400,000'
WHEN Annual_income BETWEEN 400000 AND 500000 THEN '400,000 - 500,000'
WHEN Annual_income BETWEEN 600000 AND 700000 THEN '600,000 - 700,000'
WHEN Annual_income BETWEEN 700000 AND 800000 THEN '700,000 - 800,000'
WHEN Annual_income BETWEEN 800000 AND 900000 THEN '800,000 - 900,000'
WHEN Annual_income BETWEEN 900000 AND 1000000 THEN '900,000 - 1000000'
ELSE '1000000+'
END AS income_range, approved
FROM credit_card)

SELECT income_range, 
SUM(CASE
WHEN approved = 1 THEN 1 ELSE 0 END) AS 'total_num'
FROM income_table
GROUP BY 1
ORDER BY 2;

# How does the employment class affect approval rate. Does the type of work affect approval rate ?
SELECT CASE
WHEN Employed_days LIKE '%-%' THEN 'Employed'
ELSE 'Unemployed' END AS Employment_class, Type_income,
ROUND(100 * SUM(CASE 
WHEN approved = 1 THEN 1 ELSE 0 END)/COUNT(*),2) AS total_percentage_approved, 
ROUND(100 * SUM(CASE WHEN approved = 0 THEN 1 ELSE 0 END)/COUNT(*),2) AS total_percentage_declined
FROM credit_card
GROUP BY 1, 2
ORDER BY 2;

# Does count of chidren affect approval rate ?
SELECT Children, 
ROUND(100 * SUM(CASE 
WHEN Approved = 1 THEN 1 ELSE 0 END)/COUNT(*),2) AS 'percentage_approved',
ROUND(100 * SUM(CASE WHEN Approved = 0 THEN 1 ELSE 0 END)/COUNT(*),2) AS 'percentage_declined'
FROM credit_card
GROUP BY 1
ORDER BY 1;

# Does count of cidren and marital status affect approval rate ?
SELECT Children, Marital_status,
ROUND(100 * SUM(CASE 
WHEN Approved = 1 THEN 1 ELSE 0 END)/COUNT(*),2) AS 'percentage_approved',
ROUND(100 * SUM(CASE WHEN Approved = 0 THEN 1 ELSE 0 END)/COUNT(*),2) AS 'percentage_declined'
FROM credit_card
GROUP BY 1, 2
ORDER BY 2, 1;


