# Loan-Portfolio-Overview-Approval-Analysis
End-to-end analytics project combining SQL, Python, and Power BI to analyze loan approvals and portfolio performance.

Dashboard Link: https://app.powerbi.com/view?r=eyJrIjoiMjYzZTgzOTYtYThjZC00YzIwLTg2OWYtNTc3MmE0MTEyYTMwIiwidCI6ImE0NTY1N2M1LWQ5OTYtNDhjZS04MDNjLTQyNjdjYjVhYjM3MyIsImMiOjN9

## 1. Project Overview

This project analyzes 50,000 loan applications across Credit Cards, Personal Loans, and Lines of Credit to understand lending behavior, customer risk profiles, and approval patterns. Using a full analytics pipeline (Python → PostgreSQL → Power BI), the project explores how credit score, income, debt, age, occupation, and loan intent influence loan approval decisions and portfolio exposure.

The analysis focuses on answering real-world financial questions such as:

-Which loan products and categories drive the highest approved loan amounts?

-How do approval rates vary across credit bands, income levels, and occupations?

-Which customer segments carry the most total debt?

-How debt-to-income ratios can be used to segment customers by risk level.

The final output is an interactive Power BI dashboard that provides a clear, executive-level view of loan performance, customer demographics, and approval trends, designed to support data-driven decision-making in a financial institution.

## 2. Dataset Summary

-Rows: 50,000

-Columns: 20

-Key Features:
  -Customer Demographics(Age, Occupation Status, Annual Income, etc.)
  
  -Loan Details(Loan Type, Loan Intent, Loan Status, etc.)

-Range Dictionary: 
  - age_group:

      -24 or less: Young Adult
    
      -25 to to 39: Adult

      -40 to 54: Middle-Aged

      -Above 54: Senior
    
  - credit_band:

      -Less than 580: Poor

      -Less than 670: Fair

      -Less than 740: Good

      -Less than 800: Very Good

      -Greater than or equal to 800: Excellent
    
  - income_band:

      -Less than 40000: Low

      -Less than 75000: Lower-Middle

      -Less than 120000: Upper-Middle

      -Greater than or equal to 120000: High

## 3. Exploratory Data Analysis using Python

We began with data preparation and cleaning in Python:
-Data Loading: Imported the dataset using pandas.
-Initial Exploration: Used df.info() to check structure and .describe() for summary statistics.
<img width="501" height="620" alt="image" src="https://github.com/user-attachments/assets/5ecc290f-715c-4c2c-a042-b38cc3589aaa" />

<img width="1388" height="410" alt="image" src="https://github.com/user-attachments/assets/a737a5e4-fb34-434f-8e27-156b75aeb894" />
<img width="1098" height="388" alt="image" src="https://github.com/user-attachments/assets/a393a58e-9458-4e92-aa20-81f44bf846fd" />

-Missing Data Handling: Checked for null values using .isnull().sum()

-Column Standardization: Checked to make sure columns were snake case for better readability and documentation.

-Feature Engineering:
  -Created age_group by binning customer ages
  -Created credit_band by binning credit scores
  -Created income_band by binning incomes

-Database Integration: Connected Python script to PostgreSQL and loaded the cleaned DataFrame into the database for SQL analysis

## 4. Data Analysis using SQL

We performed structured analysis in PostgreSQL to answer key business questions:

--Which product type has the biggest approved loan amounts?

<img width="294" height="128" alt="image" src="https://github.com/user-attachments/assets/8e6283fa-481c-45f1-a627-f90694830aa3" />

--Which age group has the most amount of debt?

<img width="251" height="150" alt="image" src="https://github.com/user-attachments/assets/a2414967-f6f6-4ce4-935e-1d27f9d31c37" />

--Which income band has the best and worst credit scores on average?

<img width="320" height="152" alt="image" src="https://github.com/user-attachments/assets/0b4acad1-b991-40aa-9af9-bc3b0e6b4142" />

--Which loan intent do we get the most of? The least of?

<img width="432" height="191" alt="image" src="https://github.com/user-attachments/assets/58c07c1d-9377-46fa-9091-b3488a48b999" />

--Is there a clear distinction between % of approved loans based on your credit score?

<img width="555" height="177" alt="image" src="https://github.com/user-attachments/assets/c7e8b688-06f2-4ca8-a536-cffbd795cd15" />

--Is there a correlation between annual income vs. credit score?

<img width="206" height="77" alt="image" src="https://github.com/user-attachments/assets/2e9bd2d4-0f4c-4593-b173-97352646d974" />

--What is the total loan amount that was approved in this snapshot?

<img width="256" height="70" alt="image" src="https://github.com/user-attachments/assets/3fe0d861-0199-444f-80dc-a82831f53247" />

--Which customers applied for a loan that was more than the average loan amount request of that product type?

<img width="564" height="477" alt="image" src="https://github.com/user-attachments/assets/ba4849f4-1299-4e37-b0c9-78ee855b7ff6" />

--What are the top 3 loan intent category with the highest average interest rate?

<img width="292" height="127" alt="image" src="https://github.com/user-attachments/assets/be946881-388a-400c-aa5d-5946cc008584" />

--How do the different occupation status affect loan approval rates?

<img width="457" height="130" alt="image" src="https://github.com/user-attachments/assets/4c30f5b9-ffd2-4d2e-b577-52c56d1b93ad" />

--Segment customers into Minimal Risk, Low Risk, Moderate Risk, Elevated Risk, and High Risk based on their debt to income ratio.

<img width="2158" height="476" alt="image" src="https://github.com/user-attachments/assets/f1a08e85-f308-428c-94a1-8770fe742935" />
<img width="849" height="476" alt="image" src="https://github.com/user-attachments/assets/ba076b1b-b40e-49aa-bcd8-906953c99b52" />

--Create a total debt column by combining their current debt with the approved loan amount to calculate the total amount of debt in each category of age.

<img width="333" height="159" alt="image" src="https://github.com/user-attachments/assets/df3d43fb-5874-4218-888d-60b3d79d5a5f" />

## 5. Dashboard in Power BI

Finally, we built an interactive dashboard in Power BI to present insights visually.

<img width="2251" height="1234" alt="image" src="https://github.com/user-attachments/assets/2eb582c3-fb54-4d34-baa0-0d2e3cc65494" />

## 6. Business Recommendations

### Use portfolio insights to guide capital allocation
The approval and exposure trends highlighted in the dashboard can support more balanced capital allocation decisions, helping maintain portfolio stability while continuing to grow lending activity.

### Monitor total debt levels across age groups
When combining existing debt with newly approved loans, some age groups carry significantly higher total debt. These customers may benefit from closer monitoring or proactive risk management to prevent future delinquencies.

### Focus growth on lower-risk customer segments
Certain age groups and occupation statuses show higher approval rates and lower overall risk. These segments present opportunities for portfolio growth without significantly increasing credit risk.

### Use debt-to-income (DTI) more directly in underwriting decisions
The DTI segmentation shows a clear separation between low-risk and high-risk borrowers. Incorporating these risk tiers into the approval process can speed up decisions for low-risk customers and flag higher-risk applications for closer review.

### Manage exposure across loan products
Some loan products account for a much larger share of approved loan amounts. Setting product-level limits or adjusting approval thresholds can help prevent over-concentration in any single product type.
