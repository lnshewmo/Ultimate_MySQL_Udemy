-- RELATIONSHIPS

-- 1:1, 1:many, many:many
-- store data in separate tables to reduce duplication, increase storage efficiency
-- define relationships among tables with keys

use pet_shop;
DESC customers;
select * from customers;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
    
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
SELECT * FROM orders;

INSERT INTO orders (order_date, amount, customer_id) VALUES ('2022-11-11',78.99, 54);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`pet_shop`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`))

-- obtain total order amount for customer George ?
SELECT id FROM customers WHERE last_name = 'George';  	-- find id for George
SELECT * FROM orders WHERE customer_id=1; 				-- use id to get orders

-- use a subquery?
SELECT * FROM orders WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George'); 

-- use joins to assemble data from multiple tables into one 

-- cross join (not useful or meaningful)
SELECT * FROM customers, orders;


