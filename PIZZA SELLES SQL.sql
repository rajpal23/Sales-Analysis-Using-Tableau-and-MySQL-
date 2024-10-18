CREATE DATABASE IF NOT EXISTS pizzasales;

use pizzasales;
SELECT * FROM pizza_sales;

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

SELECT sum(TOTAL_PRICE)/count(distinct ORDER_ID) AS Avg_Order_Value from pizza_sales;

SELECT SUM(QUANTITY) AS Total_Pizza_sold FROM pizza_sales;

select count(distinct order_id) as Total_orders From pizza_sales;

SELECT	CAST(SUM(QUANTITY) / COUNT(DISTINCT ORDER_ID) AS DECIMAL(10,2))
 AS Avg_pizza_per_order	FROM pizza_sales;
 
 -- Hourly Trend For Total Pizza Sold-- 
SELECT HOUR(order_time) AS order_hours, 
SUM(quantity) AS Total_Pizza_sold
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time) asc
LIMIT 0, 1000;                                                                                                                                                                                            

 -- weekly Trend for Total Orders--
SELECT WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 1) AS WeekNumber, 
YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) AS Year, 
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY 
    WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 1), 
    YEAR(STR_TO_DATE(order_date, '%Y-%m-%d'))
ORDER BY Year, WeekNumber;

-- Percentage of sales by Pizza Categiries--
SELECT  pizza_category,  
    FORMAT(SUM(total_price), 2) AS total_sales,
    FORMAT(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS percentage 
FROM pizza_sales 
GROUP BY pizza_category 
ORDER BY pizza_category ASC 
LIMIT 0, 1000;

-- Percentage of sales by Pizza Size --
select pizza_size,
format(sum(total_price),2) AS total_sales,
format(sum(total_price)*100/ (select sum(total_price) from pizza_sales),2) AS pecentage
FROM pizza_sales
group by pizza_size
order by pizza_size ASC
LIMIT 0,1000;

-- Top 5 pizzas b7 Revenue--
select  pizza_name,
sum(total_price)  as total_revenue
From pizza_sales
group by pizza_name
order by total_revenue DESC
limit 5;

-- Bottom 5 pizzas by revenue--
select pizza_name,
cast(sum(total_price) AS DECIMAL (10,2)) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue ASC
limit 5;

-- top 5 pizzas by Total Pizza Sold--
select pizza_name,
sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity DESC
limit 5;

-- Bottom 5 Pizzas by Total Pizza Sold--
select pizza_name,
sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity ASC
limit 5;

-- top 5 pizza by total orders --
select pizza_name,
count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders DESC
limit 5;

-- bottom 5 pizzas by total order--
select pizza_name,
count(distinct order_id) as total_order
from pizza_sales
group by pizza_name
order by total_order ASC
limit 5;

-- total orders and pizza sold by pizza category--
select pizza_category,
count(distinct order_id) as total_orders,
sum(quantity) as number_pizza_sold
from pizza_sales
group by pizza_category
order by number_pizza_sold
limit 1000;