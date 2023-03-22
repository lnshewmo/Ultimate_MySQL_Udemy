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
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

drop table orders;
    
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
-- no customer id 54 in the customers table so this insert fails

DELETE FROM customers WHERE last_name = 'George';
-- this is possible because of ON DELETE CASCADE clause in table setup, would otherwise error because of foreign key constraint

-- obtain total order amount for customer George ?
SELECT id FROM customers WHERE last_name = 'George';  	-- find id for George
SELECT * FROM orders WHERE customer_id=1; 				-- use id to get orders

-- use a subquery?
SELECT * FROM orders WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George'); 

-- use joins to assemble data from multiple tables into one 

-- cross join (not useful or meaningful)
SELECT * FROM customers, orders;

-- INNER JOIN - overlapping data from both tables only

SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON orders.customer_id = customers.id;

SELECT first_name, last_name, order_date, amount FROM orders
JOIN customers ON customers.id = orders.customer_id;

	-- use GROUP BY and SUM 
    SELECT first_name, last_name, SUM(amount) as total FROM orders
	JOIN customers ON customers.id = orders.customer_id
    GROUP BY first_name, last_name
    ORDER BY total;
    
-- LEFT JOIN - all data from left table (including nulls), with only overlapping data from right table.

SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

	-- use GROUP BY
    SELECT first_name, last_name, IFNULL(SUM(amount), 0) as total FROM customers
	LEFT JOIN orders ON orders.customer_id = customers.id
    GROUP BY first_name, last_name
    ORDER BY total;
    
-- RIGHT JOIN - all data from right table (including nulls), with only overlapping data fron left table
INSERT INTO orders (order_date, amount)
VALUES (CURDATE(), 100);

SELECT * FROM orders;

SELECT first_name, last_name, order_date, amount FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- Exercise
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(25)
    );
    
CREATE TABLE papers (
	title VARCHAR(100),
    grade INT,
    student_id INT, 
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
    );
    
INSERT INTO students (first_name) VALUES
('Caleb'),('Samantha'),('Raj'),('Carlos'),('Lisa');

INSERT INTO papers (student_id, title, grade) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through the Ages', 94),
(2, 'De Montaigne and the Art of the Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade FROM students
INNER JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

SELECT first_name, title, grade from students
LEFT JOIN papers on students.id = papers.student_id;

SELECT first_name, IFNULL(title, 'MISSING') AS title, IFNULL(grade, 0) AS grade FROM papers
RIGHT JOIN students ON students.id = papers.student_id;

SELECT 
first_name, 
IFNULL(avg(grade), 0) AS average, 
	CASE 
		WHEN IFNULL(avg(grade), 0) >= 75 THEN 'Passing'
        ELSE 'Failing'
    END AS passing_status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name ORDER BY average DESC;