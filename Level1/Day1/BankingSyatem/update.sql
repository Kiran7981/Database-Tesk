USE bad_bankingdb;

SELECT 'ACCOUNT FILE' AS source, address
FROM account_file WHERE customer_id='C001'

UNION ALL

SELECT 'LOAN FILE', address
FROM loan_file WHERE customer_id='C001'

UNION ALL

SELECT 'CREDIT CARD FILE', address
FROM credit_card_file WHERE customer_id='C001';