-- ========================================================
-- PROJECT 4: E-COMMERCE DATABASE SETUP (olist_db)
-- ========================================================

CREATE DATABASE IF NOT EXISTS olist_db;
USE olist_db;

-- 1. Customers Table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_state VARCHAR(5)
);

INSERT INTO customers VALUES
('c101', 'SP'), ('c102', 'RJ'), ('c103', 'SP'), 
('c104', 'MG'), ('c105', 'SP'), ('c106', 'RJ');

-- 2. Orders Table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

INSERT INTO orders VALUES
('o001', 'c101', 'delivered', '2025-01-05 10:00:00', '2025-01-10 14:00:00', '2025-01-15 00:00:00'),
('o002', 'c101', 'delivered', '2025-02-10 11:30:00', '2025-02-18 16:00:00', '2025-02-16 00:00:00'), -- Late delivery
('o003', 'c102', 'delivered', '2025-01-12 09:15:00', '2025-01-20 12:00:00', '2025-01-22 00:00:00'),
('o004', 'c103', 'delivered', '2025-01-15 14:20:00', '2025-01-19 18:00:00', '2025-01-25 00:00:00'),
('o005', 'c104', 'canceled',  '2025-02-01 08:00:00', NULL,                  '2025-02-10 00:00:00'),
('o006', 'c105', 'delivered', '2025-02-14 16:45:00', '2025-02-28 11:00:00', '2025-02-20 00:00:00'), -- Late delivery
('o007', 'c106', 'delivered', '2025-03-01 12:00:00', '2025-03-05 10:00:00', '2025-03-10 00:00:00');

-- 3. Order Items Table
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

INSERT INTO order_items VALUES
('o001', 1, 120.00, 15.00),
('o002', 1, 250.00, 25.00),
('o002', 2, 50.00,  10.00), -- Multi-item order
('o003', 1, 80.00,  12.00),
('o004', 1, 300.00, 30.00),
('o005', 1, 150.00, 20.00),
('o006', 1, 400.00, 45.00),
('o007', 1, 95.00,  10.00);