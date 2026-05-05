USE good_bankingdb;

ALTER TABLE customers
ADD email VARCHAR(100);

ALTER TABLE accounts
ADD opened_date date;

ALTER TABLE loans
ADD start_date date;

ALTER TABLE credit_cards
ADD expiry_date date