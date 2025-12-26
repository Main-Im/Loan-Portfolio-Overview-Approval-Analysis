--Which product type has the biggest approved loan amounts?

select product_type, sum(loan_amount) as total_loan_amount
from loan_data
where loan_status= 1
group by product_type
order by total_loan_amount DESC

--Which age group has the most amount of debt?

select age_group, sum(current_debt) as loan_amount
from loan_data
where loan_status=1
group by age_group
order by loan_amount DESC

--Which income band has the best and worst credit scores on average?

select income_band, AVG(credit_score) as average_credit_score
from loan_data
group by income_band
order by average_credit_score DESC

--Which loan intent do we get the most of? The least of?

select loan_intent, COUNT(*) FILTER (WHERE loan_status = 1) AS approved,
  COUNT(*) FILTER (WHERE loan_status = 0) AS denied,
  COUNT(*) AS total_requests
from loan_data
group by loan_intent
order by approved DESC, denied DESC, total_requests DESC

--Is there a clear distinction between % of approved loans based on your credit score?
with counts as (select credit_band, COUNT(*) FILTER (WHERE loan_status=1) as approved, COUNT(*) FILTER (WHERE loan_status=0) as denied, COUNT(*) as total_requests
from loan_data
group by credit_band)

select credit_band, approved, denied, total_requests, ROUND(approved/total_requests::numeric,2) as percentage
from counts

--Is there a correlation between annual income vs. credit score?

select corr(annual_income, credit_score)
from loan_data

--What is the total loan amount that was approved in this snapshot?

select sum(loan_amount)::MONEY as total_loan_amount_approved
from loan_data
where loan_status=1

--Which customers applied for a loan that was more than the average loan amount request of that product type?

with avg_loan as (
SELECT customer_id, loan_amount, product_type, ROUND(AVG(loan_amount) OVER (PARTITION BY product_type),2) AS avg_loan_amount_by_product
FROM loan_data
)

SELECT customer_id, loan_amount, product_type, avg_loan_amount_by_product
FROM avg_loan
WHERE loan_amount> avg_loan_amount_by_product


--What are the top 3 loan intent category with the highest average interest rate?

select loan_intent, avg(interest_rate) as average_interest_rate
from loan_data
group by loan_intent
order by average_interest_rate desc
limit 3


--How do the different occupation status affect loan approval rates?

SELECT occupation_status,
  COUNT(*) FILTER (WHERE loan_status = 1) AS approved,
  COUNT(*) FILTER (WHERE loan_status = 0) AS denied,
  ROUND(
    COUNT(*) FILTER (WHERE loan_status = 1)::numeric / COUNT(*),
    4
  ) AS approval_rate
FROM loan_data
GROUP BY occupation_status
ORDER BY approval_rate DESC;

--Segment customers into Minimal Risk, Low Risk, Moderate Risk, Elevated Risk, and High Risk based on their debt to income ratio.

SELECT *,
       CASE
           WHEN debt_to_income_ratio < 0.20 THEN 'Minimal Risk'
           WHEN debt_to_income_ratio <= 0.35 THEN 'Low Risk'
           WHEN debt_to_income_ratio <= 0.43 THEN 'Moderate Risk'
           WHEN debt_to_income_ratio <= 0.50 THEN 'Elevated Risk'
           WHEN debt_to_income_ratio > 0.50 THEN 'High Risk'
           ELSE 'Unknown'
       END AS customer_segment
FROM loan_data;


--Create a total debt column by combining their current debt with the approved loan amount to calculate the total amount of debt in each category of age.
with total_debt_column as (select *, 
CASE
	WHEN loan_status= 1 THEN loan_amount+ current_debt
	WHEN loan_status= 0 THEN current_debt
	ELSE NULL
	END AS total_approved_debt
	from loan_data )
	
select *
from total_debt_column;


with total_debt_column as (select *, 
CASE
	WHEN loan_status= 1 THEN loan_amount+ current_debt
	WHEN loan_status= 0 THEN current_debt
	ELSE NULL
	END AS total_approved_debt
	from loan_data )
	
select age_group, sum(total_approved_debt) as sum_total_approved_debt
from total_debt_column
group by age_group
order by sum_total_approved_debt DESC