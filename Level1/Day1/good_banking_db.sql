CREATE DATABASE good_bankingdb;
USE good_bankingdb;

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