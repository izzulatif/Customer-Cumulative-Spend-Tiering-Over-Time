# Project 4: E-Commerce Order Lifecycle & Customer Analytics (Olist Capstone)

## Overview
This repository contains the final capstone project for my SQL portfolio, utilizing a relational schema modeled after the publicly available **Brazilian E-Commerce Public Dataset by Olist**. The project demonstrates advanced SQL querying techniques to analyze customer purchasing behavior, fulfillment logistics bottlenecks, and customer lifetime value/spending tiers.

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

### Query 2: Late Delivery Breakdown & Delay Analysis by State
* **Business Objective:** Identify regional logistics bottlenecks by computing total delivered orders, late delivery volume, failure rates, and average delay duration.
* **SQL Techniques:** Conditional Aggregation (`SUM(CASE WHEN ...)`, `COUNT(CASE WHEN ... END)`), Date Math (`DATEDIFF`), and `GROUP BY`.

### Query 3: Customer Cumulative Spend & Tiering Over Time
* **Business Objective:** Monitor customer lifetime value growth by calculating order-level totals and running cumulative spending partitioned by customer over time.
* **SQL Techniques:** Multi-table joins, order-level aggregation, Window Functions (`SUM() OVER (PARTITION BY ... ORDER BY ...)`), and conditional tiering logic.

---

## How to Run
1. Execute `schema_setup.sql` in MySQL Workbench to build the database and populate test data.
2. Run `project4_queries.sql` to execute the analytical pipeline.