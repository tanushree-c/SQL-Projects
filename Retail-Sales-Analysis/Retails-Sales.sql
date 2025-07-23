-- Create Database and Use It
CREATE database `retail sales analysis`;
USE `retail sales analysis`;

-- Create Table: retail_sales
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Basic Exploratory Queries

-- Sales made by the retailer
SELECT 
    COUNT(*) AS total_sales
FROM
    retail_sales;


-- How many customers does the retailer have?
SELECT 
    COUNT(DISTINCT customer_id) AS `Customers`
FROM
    retail_sales;


-- Which categories does the retailer have?
SELECT DISTINCT
    category
FROM
    retail_sales;



-- Data Analysis & Business Key Problems and Answers

-- Q.1: Retrieve all transactions made on a specific date (2022-11-05)
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';


-- Q.2: Transactions from the 'Clothing' category with quantity >= 4 in November 2022
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';


-- Q.3: Total number of transactions and total sales per category
SELECT 
    category,
    COUNT(*) AS `Total Transactions`,
    SUM(total_sale) AS `Total Sales`
FROM
    retail_sales
GROUP BY category;


-- Q.4: Average age of customers who purchased items from the 'Beauty' category
SELECT 
    ROUND(AVG(age), 0) AS `Average Age`,
    category
FROM
    retail_sales
WHERE
    category = 'Beauty';


-- Q.5: Transactions where the total sale value exceeds 1000
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;


-- Q.6: Total number of transactions by gender and category
SELECT 
    gender, category, COUNT(transactions_id) AS Transactions
FROM
    retail_sales
GROUP BY gender, category;


-- Q.7: Find the best-selling month of each year based on the highest average total sales
SELECT 
    Avg_Sale_table1.sale_year as Year,
    Avg_Sale_table1.Sale_month as `Best Selling Month`,
    yearly_max_avg.max_avg_amt as `Avg Sale`
FROM
    (SELECT 
        MONTHNAME(sale_date) AS sale_month,
		YEAR(sale_date) AS sale_year,
		ROUND(AVG(total_sale), 2) AS Avg_sale
    FROM
        retail_sales
    GROUP BY sale_year , sale_month) AS Avg_Sale_table1
        JOIN
    (SELECT 
        sale_year, MAX(Avg_sale) AS max_avg_amt
    FROM
        (SELECT 
			MONTHNAME(sale_date) AS sale_month,
            YEAR(sale_date) AS sale_year,
            ROUND(AVG(total_sale), 2) AS Avg_sale
		FROM
			retail_sales
		GROUP BY sale_year , sale_month) AS Avg_Sale_table2
    GROUP BY sale_year) AS yearly_max_avg ON Avg_Sale_Table1.sale_year = yearly_max_avg.sale_year
        AND Avg_Sale_Table1.Avg_sale = yearly_max_avg.max_avg_amt
ORDER BY Avg_Sale_Table1.sale_year;


-- Q.8: Top 5 customers based on highest total sales
SELECT 
    customer_id, SUM(total_sale) AS total_sale
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;


-- Q.9: Number of unique customers who purchased items from each category
SELECT 
    COUNT(DISTINCT customer_id) AS unique_customers, category
FROM
    retail_sales
GROUP BY category
ORDER BY unique_customers DESC;


-- Q.10: Classify sales into Morning, Afternoon, and Evening shifts and count number of orders
SELECT 
    shift, number_of_orders
FROM
    (SELECT 
        CASE
		WHEN HOUR(sale_time) <= 12 THEN 'Morning'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift,
	COUNT(*) AS number_of_orders
    FROM
        retail_sales
    GROUP BY shift) AS shift_data
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');
