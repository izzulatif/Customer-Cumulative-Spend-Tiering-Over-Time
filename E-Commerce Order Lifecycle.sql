-- ========================================================
-- PROJECT 4: ADVANCED SQL ANALYTICAL QUERIES
-- ========================================================

USE olist_db;

-- ------------------------------------------------------------------------
-- Query 1: Customer Order Sequence & Days Between Purchases
-- ------------------------------------------------------------------------
WITH orderseq AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        ROW_NUMBER() OVER(
            PARTITION BY o.customer_id 
            ORDER BY o.order_purchase_timestamp ASC, o.order_id ASC
        ) AS row_num,
        LAG(o.order_purchase_timestamp) OVER(
            PARTITION BY o.customer_id 
            ORDER BY o.order_purchase_timestamp ASC, o.order_id ASC
        ) AS prev_timestamp
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
)
SELECT 
    order_id,
    customer_id,
    order_purchase_timestamp, 
    prev_timestamp,
    DATEDIFF(order_purchase_timestamp, prev_timestamp) AS elapsed_days_since_last_order
FROM orderseq;


-- ------------------------------------------------------------------------
-- Query 2: Late Delivery Breakdown & Delay Analysis by State
-- ------------------------------------------------------------------------
WITH deliverybreakdown AS (
	SELECT
		o.order_id,
        o.customer_id,
        c.customer_state,
        o.order_status,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date
	FROM orders o
    INNER JOIN customers c
		ON o.customer_id = c.customer_id
)
SELECT
	customer_state,
    SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) AS total_delivered_order,
    COUNT(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 END) AS late_delivery,
    AVG(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) END) AS avg_delay_days
FROM deliverybreakdown
GROUP BY customer_state;


-- ------------------------------------------------------------------------
-- Query 3: Customer Cumulative Spend & Tiering Over Time
-- ------------------------------------------------------------------------
WITH cumspending AS (
	SELECT
        o.order_id,
        o.customer_id,
        c.customer_state,
        o.order_purchase_timestamp,
        SUM(oi.price + oi.freight_value) AS total_spend_per_order
	FROM orders o
    INNER JOIN customers c
		ON o.customer_id = c.customer_id
	INNER JOIN order_items oi
		ON o.order_id = oi.order_id
	GROUP BY o.order_id, o.customer_id, c.customer_state, o.order_purchase_timestamp
)
SELECT
	order_id,
    customer_id,
    customer_state,
    order_purchase_timestamp,
    total_spend_per_order,
    SUM(total_spend_per_order) OVER(
        PARTITION BY customer_id 
        ORDER BY order_purchase_timestamp ASC, order_id ASC
    ) AS cumulative_spending_per_customer,
    CASE 
        WHEN total_spend_per_order > 300 THEN 'High Spender' 
        ELSE 'Standard' 
    END AS spending_tier
FROM cumspending
ORDER BY customer_id ASC, order_purchase_timestamp ASC;