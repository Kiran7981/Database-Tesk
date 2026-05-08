CREATE DATABASE ecommercedb;
USE ecommercedb;

drop table if exists products;
drop table if exists inventory_stock;

CREATE TABLE products (
	product_id int auto_increment primary key,
    product_name varchar(50),
    sku varchar(50) unique,
    selling_price decimal(10,2)
);

create table inventory_stock(
	stock_id int auto_increment primary key,
    product_id int,
    quantity int,
    foreign key (product_id) references products(product_id)
);

create table sell_orders(
	sell_order_id bigint auto_increment primary key,
    order_number varchar(50) unique not null,
    customer_id bigint null,
    warehouse_id int null,
    order_date datetime not null default current_timestamp,
    status enum('PENDING','CONFIRMED','SHIPPED','DELIVERED','CANCELLED')
		not null default 'PENDING',
	total_amount decimal(12,2) not null default 0.00,
    remark text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

insert into products (product_name, sku, selling_price)
values 
	('iPhone14','SKU001','1000'),
    ('Rice Cooker','SKU010','200');
    
insert into inventory_stock (stock_id,product_id,quantity)
values
	(1,1,1000);

update inventory_stock 
set quantity=quantity+10 
where product_id=1;

delete from products
where product_id=2;

select product_id,product_name from products;

select *from products;
select *from sell_order;

select p.product_name, i.quantity 
from products p
join inventory_stock i on p.product_id=i.product_id;

select *from inventory_stock
where quantity>200;

-- 4. Data Control Language (DCL)
 -- Restrict warehouse staff vs admin access 
 -- Grant permission
 
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE, DELETE ON products TO 'staff_user'@'localhost';
GRANT SELECT ON products TO 'staff_user1'@'localhost';

-- Apply Changes 
FLUSH PRIVILEGES;
-- Revoke permission
REVOKE SELECT ON products FROM 'staff_user'@'localhost';
REVOKE INSERT ON products FROM 'staff_user'@'localhost';
REVOKE UPDATE ON products FROM 'staff_user'@'localhost';
REVOKE DELETE ON products FROM 'staff_user'@'localhost';

START TRANSACTION;

-- Deduct stock
UPDATE inventory_stock
SET quantity = quantity - 1
WHERE product_id = 1;

-- Insert sales order

INSERT INTO sell_orders (order_number, total_amount, status)
VALUES ('SO1003', 2000, 'CONFIRMED');
INSERT INTO sell_orders 
(order_number, customer_id, warehouse_id, total_amount)
VALUES 
('SO1004', 1, 1, 1200);

INSERT INTO sell_orders (order_number, total_amount)
VALUES ('SO1005', 1500);

INSERT INTO sell_orders (order_number, total_amount)
VALUES
('SO1006', 900),
('SO1007', 1100),
('SO1008', 1300);

-- If error occurs
ROLLBACK;
-- If everything is correct
COMMIT;



SELECT * FROM sell_orders;