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

-- Relationships: MANY TO MANY
CREATE DATABASE tv_reviews;
USE tv_reviews;

CREATE TABLE reviewers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
    );
    
CREATE TABLE series (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);

CREATE TABLE reviews (
	id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL (2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);

SHOW tables;

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
     
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
SELECT * FROM reviewers;
SELECT * FROM reviews;
SELECT * FROM series;

SELECT title, rating FROM series
JOIN reviews ON series.id = reviews.series_id;

SELECT title, ROUND(AVG(rating),2) AS avg_rating FROM series
JOIN reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating DESC;

SELECT first_name, last_name, rating FROM reviewers
JOIN reviews ON reviewers.id = reviews.reviewer_id;

SELECT title AS unreviewed_series FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

-- same result using right join
SELECT title AS no_review FROM reviews
RIGHT JOIN series ON series.id = reviews.series_id
WHERE rating IS NULL;

SELECT genre, ROUND(avg(rating),2) AS avg_rating FROM series
JOIN reviews on series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;

-- can use IF() instead of CASE statement when the condition is IF/ELSE
SELECT first_name, last_name, 
	COUNT(rating) AS count, 
	IFNULL(MIN(rating),0) AS min, 
	IFNULL(MAX(rating), 0) AS max , 
	ROUND(IFNULL(AVG(rating),0), 2) AS avg,
    IF(COUNT(rating) > 0, 'active', 'inactive') AS status
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

-- use CASE statement when conditional has more than 2 conditions
SELECT first_name, last_name, 
	COUNT(rating) AS count, 
	IFNULL(MIN(rating),0) AS min, 
	IFNULL(MAX(rating), 0) AS max , 
	ROUND(IFNULL(AVG(rating),0), 2) AS avg,
    CASE			-- conditionals go top down, in this case largest to smallest 
		WHEN COUNT(rating) >= 10 THEN 'poweruser'
        WHEN COUNT(rating) >= 0 THEN 'active'
        ELSE 'inactive'
	END AS status
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

SELECT first_name, last_name, 
	COUNT(rating) AS count, 
	IFNULL(MIN(rating),0) AS min, 
	IFNULL(MAX(rating), 0) AS max , 
	ROUND(IFNULL(AVG(rating),0), 2) AS avg,
    CASE			-- smallest to largest 
		WHEN COUNT(rating) <=0 THEN 'inactive'
        WHEN COUNT(rating) BETWEEN 0 AND 9 THEN 'active'
        ELSE 'poweruser'
	END AS status
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name, last_name;

SELECT title, rating, CONCAT(first_name, ' ', last_name) AS reviewer FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id
ORDER BY title;




    
    
    

    