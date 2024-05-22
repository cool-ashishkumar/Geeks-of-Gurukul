create database sales;
Use sales;



-- Sales by year and state
SELECT YEAR(order_purchase_timestamp) AS Year, 
       customer_state, 
       SUM(price) AS Total_Sales
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), customer_state;

-- Customer acquisitions by year and state
SELECT YEAR(order_purchase_timestamp) AS Year, 
       customer_state, 
       COUNT(DISTINCT customer_id) AS Customer_Acquisitions
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), customer_state;

-- Total number of orders by year and state
SELECT YEAR(order_purchase_timestamp) AS Year, 
       customer_state, 
       COUNT(order_id) AS Total_Orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), customer_state;

-- Category level sales and orders
SELECT YEAR(order_purchase_timestamp) AS Year, 
       customer_state, 
       p.product_category_name, 
       SUM(oi.price) AS Total_Sales, 
       COUNT(oi.order_id) AS Total_Orders
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
WHERE customer_state IN ('state1', 'state2') AND YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), customer_state, p.product_category_name;

-- Post-order reviews
-- SELECT YEAR(o.order_purchase_timestamp) AS Year, 
--        c.customer_state, 
--        AVG(o.review_score) AS Average_Review_Score
-- FROM olist_orders_dataset o
-- JOIN olist_order_reviews_dataset o ON o.order_id = o.order_id
-- JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
-- WHERE c.customer_state IN ('state1', 'state2') AND YEAR(o.order_purchase_timestamp) BETWEEN 2016 AND 2018
-- GROUP BY YEAR(o.order_purchase_timestamp), c.customer_state;

-- % of orders delivered earlier and later
SELECT YEAR(order_purchase_timestamp) AS Year, 
       customer_state, 
       SUM(CASE WHEN order_delivered_customer_date < order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id) AS Percent_Early_Deliveries,
       SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id) AS Percent_Late_Deliveries
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE customer_state IN ('state1', 'state2') AND YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), customer_state;

-- City level sales and orders
SELECT YEAR(order_purchase_timestamp) AS Year, 
       c.customer_city, 
       c.customer_state, 
       SUM(oi.price) AS Total_Sales, 
       COUNT(oi.order_id) AS Total_Orders
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE c.customer_state IN ('state1', 'state2') AND YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY YEAR(order_purchase_timestamp), c.customer_city, c.customer_state;
