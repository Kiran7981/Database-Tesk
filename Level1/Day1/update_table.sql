USE good_bankingdb;

ALTER TABLE customers
ADD email VARCHAR(100);

ALTER TABLE accounts
ADD opened_date date;

ALTER TABLE loans
ADD start_date date;

ALTER TABLE credit_cards
ADD expiry_date date;

UPDATE customers
SET address = 'No.99, Inya Road, Yangon'
WHERE customer_id = 'C001';


