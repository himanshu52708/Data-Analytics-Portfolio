-- Q1 = Total Revenue

SELECT sum(revenue)  AS Total_Revenue 
FROM data_of_orders;


-- Q2 Revenue by State
SELECT state, sum(revenue)  AS Total_Revenue FROM data_of_orders
GROUP BY state
ORDER BY Total_Revenue;


-- Q3 Revenue by Product Category

SELECT product_category, sub_category, SUM(revenue) Revenue FROM data_of_orders
GROUP BY product_category, sub_category
ORDER BY Revenue DESC; 


-- Q4 Number of Unique Customers

SELECT count(distinct(customer_id)) AS Total_Customers
FROM data_of_orders;


-- Q5 Customers Who Ordered More Than Once
SELECT customer_id, count(*) no_of_orders FROM data_of_orders
group by customer_id
HAVING count(*) > 1
order by no_of_orders DESC;

-- Q6 Revenue by Customer Gender

SELECT customer_gender, SUM(revenue) Total_Revenue FROM data_of_orders
group by customer_gender
order by Total_Revenue DESC;


-- Q7 Revenue by Age Group

SELECT CASE 
WHEN customer_age < 30 THEN 'young'
WHEN customer_age between 30 and 50 THEN 'Adult'
ELSE 'Old'
END AS Age_group,
SUM(revenue) Total_Revenue
FROM data_of_orders
group by Age_group
ORDER BY Total_Revenue DESC;


-- Q8 Revenue by Education Level (JOIN)

SELECT C.education, sum(O.revenue) as total_revenue 
FROM data_of_orders AS O
JOIN data_of_customers AS C
ON C.customer_id = O.customer_id
GROUP BY education
ORDER BY total_revenue DESC;

-- Q9 Revenue by Marital Status

SELECT marital_status, SUM(revenue) total_revenue  
FROM data_of_orders O
JOIN data_of_customers C
ON C.customer_id = O.customer_id 
GROUP BY marital_status
ORDER BY total_revenue DESC;

-- Q10 Revenue by Pet Ownership

SELECT C.info_on_pets pets, sum(O.revenue) total_revenue
FROM data_of_customers C
LEFT JOIN data_of_orders O
ON O.customer_id = C.customer_id
GROUP BY pets
ORDER BY total_revenue DESC;

-- Q11 Top 10 Customers by Revenue

SELECT  customer_id AS id, sum(revenue) total_revenue
FROM data_of_orders
GROUP BY id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q12 Most Profitable State

SELECT state, sum(revenue - opex) net_profit 
FROM data_of_orders
GROUP BY state
ORDER BY net_profit DESC;


-- Q13 Average Revenue by Product Category

SELECT product_category, ROUND(avg(revenue),2) avg_revenue 
FROM data_of_orders
GROUP BY product_category
ORDER BY avg_revenue DESC;


-- Q14 – Orders Generating Above Average Revenue (Subquery)

SELECT * FROM data_of_orders
WHERE revenue > (SELECT avg(revenue) FROM data_of_orders)
ORDER BY revenue DESC;


-- Q15 – Customer Revenue Ranking (Window Function)

SELECT customer_id, SUM(revenue) AS total_revenue,
       RANK() OVER (ORDER BY SUM(revenue) DESC) AS customer_rank
FROM data_of_orders
GROUP BY customer_id;
