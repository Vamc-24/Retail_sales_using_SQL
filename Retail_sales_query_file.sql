--creating table 
create table retail_sales
		(	transactions_id	 Int Primary Key,
			sale_date Date,
			sale_time Time,
			customer_id Int,
			gender Varchar(10),
			age Int,
			category Varchar(35),
			quantity Int,
			price_per_unit float,
			cogs Float,
			total_sale Float
		);

-- checking table created or not
select * from retail_sales;

--checking the first 10 rows
select * from retail_sales
Order by transactions_id asc
limit 10;

--Data Cleaning

--checking the count of all records
select count(*) from retail_sales

--checking the null value records
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL 
	OR 
	sale_time IS NULL 
	OR 
	customer_id IS NULL 
	OR 
    gender IS NULL 
	OR 
	age IS NULL
	OR 
	category IS NULL 
	OR 
    quantity IS NULL 
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL;


-- deleting null value records
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL 
	OR 
	sale_time IS NULL 
	OR 
	customer_id IS NULL 
	OR 
    gender IS NULL 
	OR 
	age IS NULL
	OR 
	category IS NULL 
	OR 
    quantity IS NULL 
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL;

--Reconforming the count of all records after deleting the null value records
select count(*) from retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL 
	OR 
	sale_time IS NULL 
	OR 
	customer_id IS NULL 
	OR 
    gender IS NULL 
	OR 
	age IS NULL
	OR 
	category IS NULL 
	OR 
    quantity IS NULL 
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL;

--Data Exploring

--How many sales we have?
select count(*) as Total_sales from retail_sales;

--How many unique customers we have?
select count(distinct Customer_id) as Unique_customers from retail_sales;

--How many unique category we have?
select count(distinct category) as Unique_category from retail_sales;

select distinct category from retail_sales;

--Data Analysis
select * from retail_sales
	
--Q1 : Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date ='2022-11-05';

--Q2 :Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * 
	from retail_sales
where category='Clothing' 
	and 
	quantity >=4 
	and 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	
--Q3 :Write a SQL query to calculate the total sales (total_sale) for each category.:
select 
	category,
	sum(Total_sale) as net_sales,
	count(*)
from retail_sales
 	group by 1

--Q4 :Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),2) as Avg_age 
	from retail_sales 
 	where category='Beauty'

--Q5 :Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select count(*) from retail_sales
where total_sale >1000

--Q6 :Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 select category, gender, count(*)
from retail_sales
group
	by
	1,2
Order by 1
	
--Q7 :Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Q8:Write a SQL query to find the top 5 customers based on the highest total sales
select  customer_id,sum(total_sale) as net_sale from retail_Sales
group by 1
Order by net_sale  desc
limit 5

--Q9 :Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


--Q10 :Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
	WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift



-- End of Project