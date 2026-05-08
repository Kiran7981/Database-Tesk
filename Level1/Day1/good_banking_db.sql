CREATE DATABASE good_bankingdb;
USE good_bankingdb;

DROP TABLE IF EXISTS credit_cards;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(30)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    account_type VARCHAR(50),
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    loan_type VARCHAR(50),
    loan_amount DECIMAL(12,2),
    outstanding_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE credit_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    card_number VARCHAR(30),
    card_type VARCHAR(50),
    credit_limit DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers
(customer_id, customer_name, address, phone, email)
VALUES
('C001', 'Aung Aung', 'No.10, Pyay Road, Yangon', '09-111111111', 'aung@example.com'),
('C002', 'Su Su', 'No.22, Hledan Street, Yangon', '09-222222222', 'susu@example.com'),
('C003', 'Kyaw Kyaw', 'No.45, Mandalay Road, Mandalay', '09-333333333', 'kyaw@example.com');

INSERT INTO accounts
(customer_id, account_type, balance, opened_date)
VALUES
('C001', 'Savings', 500000.00, '2024-01-10'),
('C002', 'Current', 1200000.00, '2024-02-15'),
('C003', 'Savings', 300000.00, '2024-03-01');

INSERT INTO loans
(customer_id, loan_type, loan_amount, outstanding_amount, start_date)
VALUES
('C001', 'Home Loan', 10000000.00, 7500000.00, '2024-04-01'),
('C002', 'Car Loan', 5000000.00, 2000000.00, '2024-05-10');

INSERT INTO credit_cards
(customer_id, card_number, card_type, credit_limit, expiry_date)
VALUES
('C001', '4111111111111111', 'Gold', 2000000.00, '2028-12-31'),
('C003', '4222222222222222', 'Classic', 1000000.00, '2027-11-30');

SELECT 
c.customer_id, 
c.customer_name, 
c.address, 
a.account_type, 
a.balance, l.loan_type, 
l.outstanding_amount, 
cc.card_number, 
cc.card_type 
FROM customers c 
LEFT JOIN accounts a 
ON c.customer_id = a.customer_id 
LEFT JOIN loans l 
ON c.customer_id = l.customer_id 
LEFT JOIN credit_cards cc 
ON c.customer_id = cc.customer_id 
WHERE c.customer_id = 'C001';

CREATE VIEW vw_customer_banking_profile AS 
SELECT 
c.customer_id, 
c.customer_name, 
c.address, 
c.phone, 
a.account_id, 
a.account_type, 
a.balance, 
l.loan_id, 
l.loan_type, 
l.loan_amount, 
l.outstanding_amount, 
cc.card_id, 
cc.card_number, 
cc.card_type, 
cc.credit_limit 
FROM customers c 
LEFT JOIN accounts a 
ON c.customer_id = a.customer_id 
LEFT JOIN loans l 
ON c.customer_id = l.customer_id 
LEFT JOIN credit_cards cc 
ON c.customer_id = cc.customer_id; 
SELECT * FROM vw_customer_banking_profile 
WHERE customer_id = 'C001';

SELECT * FROM vw_customer_banking_profile;