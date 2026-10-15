# Project 4: E-Commerce Order Lifecycle & Customer Analytics (Olist Capstone)

## Overview
This repository contains the final capstone project for my SQL portfolio, utilizing a relational schema modeled after the publicly available **Brazilian E-Commerce Public Dataset by Olist**. The project demonstrates advanced SQL querying techniques to analyze customer purchasing behavior, fulfillment logistics bottlenecks, and customer lifetime value/spending tiers.

---

## Database Schema & Architecture
The database (`olist_db`) consists of three core relational tables:
* **`customers`**: Stores unique customer identifiers and regional state locations (`customer_state`).
* **`orders`**: Tracks order lifecycles, purchase timestamps, delivery dates, and estimated delivery dates.
* **`order_items`**: Captures line-item granularity, including individual item prices and freight values.

---

## Analytical Queries & Technical Implementation

### Query 1: Customer Order Sequence & Days Between Purchases
* **Business Objective:** Track repeat customer purchasing cadence and calculate the time elapsed between consecutive orders.
* **SQL Techniques:** CTEs, `ROW_NUMBER()`, `LAG()`, `DATEDIFF()`, and deterministic tie-breaking.

#### Sample Output:
| order_id | customer_id | order_purchase_timestamp | prev_timestamp | elapsed_days_since_last_order |
| :--- | :--- | :--- | :--- | :--- |
| o001 | c101 | 2025-01-05 10:00:00 | NULL | NULL |
| o002 | c101 | 2025-02-10 11:30:00 | 2025-01-05 10:00:00 | 36 |
| o003 | c102 | 2025-01-12 09:15:00 | NULL | NULL |
| o004 | c103 | 2025-01-15 14:20:00 | NULL | NULL |

---

### Query 2: Late Delivery Breakdown & Delay Analysis by State
* **Business Objective:** Identify regional logistics bottlenecks by computing total delivered orders, late delivery volume, failure rates, and average delay duration.
* **SQL Techniques:** Conditional Aggregation (`SUM(CASE WHEN ...)`, `COUNT(CASE WHEN ... END)`), Date Math (`DATEDIFF`), and `GROUP BY`.

#### Sample Output:
| customer_state | total_delivered_order | late_delivery | avg_delay_days |
| :--- | :--- | :--- | :--- |
| SP | 4 | 2 | 5.0000 |
| RJ | 2 | 0 | NULL |
| MG | 0 | 0 | NULL |

---

### Query 3: Customer Cumulative Spend & Tiering Over Time
* **Business Objective:** Monitor customer lifetime value growth by calculating order-level totals and running cumulative spending partitioned by customer over time.
* **SQL Techniques:** Multi-table joins, order-level aggregation, Window Functions (`SUM() OVER (PARTITION BY ... ORDER BY ...)`), and conditional tiering logic.

#### Sample Output:
| order_id | customer_id | customer_state | order_purchase_timestamp | total_spend_per_order | cumulative_spending_per_customer | spending_tier |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| o001 | c101 | SP | 5/1/2025 10:00 | 135 | 135 | Standard |
| o002 | c101 | SP | 10/2/2025 11:30 | 335 | 470 | High Spender |
| o003 | c102 | RJ | 12/1/2025 9:15 | 92 | 92 | Standard |
| o004 | c103 | SP | 15/1/2025 14:20 | 330 | 330 | High Spender |
| o005 | c104 | MG | 1/2/2025 8:00 | 170 | 170 | Standard |
| o006 | c105 | SP | 14/2/2025 16:45 | 445 | 445 | High Spender |
| o007 | c106 | RJ | 1/3/2025 12:00 | 105 | 105 | Standard |


---

## How to Run
1. Execute `E-COMMERCE DATABASE SETUP.sql` in MySQL Workbench to build the database and populate test data.
2. Run `E-Commerce Order Lifecycle.sql` to execute the analytical pipeline.
