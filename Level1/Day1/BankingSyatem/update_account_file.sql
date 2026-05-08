USE bad_bankingdb;

-- then create tables
-- then insert data

SET SQL_SAFE_UPDATES = 0;

UPDATE account_file
SET address = 'New Address'
WHERE customer_id = 'C001';