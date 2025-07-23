# Retail Sales SQL Analysis

This repository contains SQL queries to perform exploratory and analytical insights on a retail sales dataset. The dataset includes transaction-level information such as sale date, time, customer demographics, product categories, and sales details.

---

## Dataset Schema

**Table:** `retail_sales`

| Column          | Data Type   | Description                             |
|-----------------|-------------|-----------------------------------------|
| transactions_id | INT         | Unique identifier for each transaction  |
| sale_date       | DATE        | Date of the sale                        |
| sale_time       | TIME        | Time of the sale                        |
| customer_id     | INT         | Unique ID of the customer               |
| gender          | VARCHAR(10) | Gender of the customer                  |
| age             | INT         | Age of the customer                     |
| category        | VARCHAR(20) | Product category                        |
| quantity        | INT         | Quantity sold                           |
| price_per_unit  | FLOAT       | Price per unit                          |
| cogs            | FLOAT       | Cost of goods sold                      |
| total_sale      | FLOAT       | Total sale value                        |


---

## SQL Queries Overview

### Time-Based Analysis
- Monthly average sales
- Best-selling month in each year (based on highest average sale)
- Number of orders by time of day (Morning, Afternoon, Evening)

### Customer Insights
- Total unique customers
- Top 5 customers by total sales
- Unique customers per category

### Product & Sales Insights
- Total sales by category
- High-value transactions (> 1000)
- Transactions grouped by gender and category

---

## Time-of-Day Shift Logic

| Shift     | Time Range       |
|-----------|------------------|
| Morning   | Before 12:00     |
| Afternoon | 12:00 – 17:00    |
| Evening   | After 17:00      |

---

## How to Use

1. Import the dataset into a MySQL database.
2. Execute the queries from `retail_sales_analysis.sql` using MySQL Workbench or CLI.
3. Review insights or export results for reporting.

> ⚠ If using MySQL 5.x, disable `ONLY_FULL_GROUP_BY` mode or use query-compliant syntax.

