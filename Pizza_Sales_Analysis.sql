## A KPI's
##1. Total Revenue:
SELECT sum(total_price) AS Total_Revenue
FROM pizza_sales;

##2. Average Order Value
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

##3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales;

##4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

##5. Average Pizzas Per Order
SELECT Round(SUM(quantity)/ COUNT(DISTINCT order_id),2) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

## B Hourly Trend For Total Pizzas Sold
SET SQL_SAFE_UPDATES = 0;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
ALTER TABLE pizza_sales
CHANGE COLUMN order_date order_date DATE;

SELECT order_date FROM pizza_sales LIMIT 10;

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');
ALTER TABLE pizza_sales
CHANGE COLUMN order_time order_time TIME;

SELECT order_time FROM pizza_sales LIMIT 10;

##Hourly Trend For Total Pizzas Sold

SELECT HOUR(order_time) AS Order_Hours, 
       SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

## C Weekly Trends For Total Orders

SELECT WEEK(order_date, 3) AS Week_Number,  -- '3' specifies ISO-8601 week mode
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY YEAR(order_date),
    WEEK(order_date, 3)
ORDER BY Year, Week_Number;

## D Percentage Of Sales by Pizza Category
SELECT pizza_category, ROUND(sum(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

## E Percentage Of Sales by Pizza Category of January
SELECT pizza_category, ROUND(SUM(total_price),2) AS Total_Sales, ROUND(sum(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1),2) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) =1
GROUP BY pizza_category;

## F Percentage Of Sales by Pizza Size
SELECT pizza_size, ROUND(SUM(total_price),2) AS Total_Sales, ROUND(sum(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT;

## G Top 5 Pizzas by Revenue
SELECT pizza_name , ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Revenue DESC
LIMIT 5;

## H Bottom 5 Pizzas by Revenue
SELECT pizza_name , ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Revenue
LIMIT 5;

## I Top 5 Pizzas by QUANTITY
SELECT pizza_name , SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Quantity DESC
LIMIT 5;

## J Bottom 5 Pizzas by QUANTITY
SELECT pizza_name , SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Quantity ASC
LIMIT 5;

## K Top 5 Pizzas by ORDERS
SELECT pizza_name , COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Orders DESC
LIMIT 5;

## L Bottom 5 Pizzas by ORDERS
SELECT pizza_name , COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
Order by Total_Orders ASC
LIMIT 5;

