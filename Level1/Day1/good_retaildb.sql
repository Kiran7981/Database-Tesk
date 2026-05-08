CREATE DATABASE good_retaildb;
USE good_retaildb;

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS products;

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_sales_store FOREIGN KEY (store_id) REFERENCES stores(store_id),
    CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO good_retaildb.stores
SELECT * FROM bad_retaildb.stores_file;

INSERT INTO good_retaildb.products
SELECT * FROM bad_retaildb.products_file;

INSERT INTO good_retaildb.sales (sale_date, store_id, product_id, quantity, total_amount)
SELECT sale_date, store_id, product_id, quantity, total_amount
FROM bad_retaildb.sales_file;

SELECT 
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region
ORDER BY total_sales DESC;

SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sales_month,
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m'), st.region
ORDER BY sales_month, st.region;

SELECT 
    st.region,
    p.category,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region, p.category
ORDER BY st.region, total_sales DESC;

DROP VIEW IF EXISTS vw_sales_reporting;

CREATE VIEW vw_sales_reporting AS
SELECT
    s.sale_id,
    s.sale_date,
    st.store_id,
    st.store_name,
    st.region,
    st.city,
    p.product_id,
    p.product_name,
    p.category,
    s.quantity,
    s.total_amount
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id;

SELECT * FROM vw_sales_reporting;

SELECT 
    st.region,
    SUM(s.total_amount) AS total_sales
FROM sales s
JOIN stores st ON s.store_id = st.store_id
WHERE s.sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY st.region
ORDER BY total_sales DESC;

SELECT 
    region,
    COUNT(*) AS transaction_count,
    SUM(total_amount) AS total_sales
FROM vw_sales_reporting
WHERE sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY region
ORDER BY total_sales DESC;

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    region,
    store_name,
    SUM(total_amount) AS total_sales
FROM vw_sales_reporting
WHERE sale_date BETWEEN '2025-10-01' AND '2026-03-31'
GROUP BY DATE_FORMAT(sale_date, '%Y-%m'), region, store_name
ORDER BY sales_month, region;