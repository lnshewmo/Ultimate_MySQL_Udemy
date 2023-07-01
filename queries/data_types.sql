-- REVISITING DATA TYPES: data types have variable storage requirements, optimize to reduce storage
use pet_shop;

-- STRING
	-- CHAR: fixed length text ex. CHAR(2) for NY, NC
	-- VARCHAR: variable length, can specify maximum length ex. VARCHAR(10)
-- NUMERIC
	-- whole numbers: TINYINT, INT, BIGINT
        -- max/min : signed (+/-), unsigned (+) values only
	-- fixed numbers: DECIMAL(#totaldigits/precision, #digitsafterdecimal/scale)
		-- values with greater precision will be rounded
    -- approximate numbers: FLOAT up to ~7 digits precision DOUBLE PRECISION up to ~15
    
DROP TABLE products;
CREATE TABLE products (
	id INT AUTO_INCREMENT,
    department VARCHAR(15),
    item VARCHAR(100),
    price DECIMAL(5,2),
    inventory SMALLINT,
    PRIMARY KEY(id)
    );
    
DESC products;
    
INSERT INTO products (department, item, price, inventory) 
VALUES 
('cat', 'toy', 4.50, 10),
('dog', 'toy', 5, 20),
('cat', 'food', 20.33, 15),
('dog', 'food', 31.99, 15),
('cat', 'bed', 25.99, 5),
('dog', 'bed', 34.99, 5),
('bird', 'seed', 16.99, 10),
('rabbit', 'treat', 12.99, 5);

SELECT * FROM products;
    
-- DATES
	-- DATE 'YYYY-MM-DD'
    -- TIME 'HH:MM:SS' can be +/-
    -- DATETIME 'YYYY-MM-DD HH:MM:SS'
    -- CURDATE
    -- CURTIME
    -- NOW
	
DROP TABLE people;

CREATE TABLE people (
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    hire_date DATE NOT NULL,
    wage DECIMAL(5,2) NOT NULL,
    position VARCHAR(10) NOT NULL
    );
    
DESC people;

INSERT INTO people (first_name, last_name, dob, hire_date, wage, position)
VALUES
('Laura', 'Miller', '1980-01-01', '2020-01-01', 15.50, 'stock'),
('Jane', 'Austen', '1985-01-01', '2022-03-01', 14.50, 'stock'),
('Murphy', 'Smith', '1990-01-01', '2020-02-01', 15.50, 'sales'),
('Stu', 'Pendous', '1999-01-01', '2022-06-01', 13.50, 'sales'),
('Penny', 'Dollar', '1975-01-01', '2019-01-01', 25.50, 'manager');

INSERT INTO people (first_name, last_name, dob, hire_date, wage, position)
VALUES ('Wallace', 'Thomas', '1998-05-01', CURDATE(), 12.50, 'stock');

SELECT * FROM people;

DROP TABLE timesheet;
CREATE TABLE timesheet (
emp_id INT NOT NULL PRIMARY KEY,
clock_in DATETIME,
clock_out DATETIME
);

DESC timesheet;

INSERT INTO timesheet (emp_id, clock_in) 
VALUES (6, NOW());

SELECT * FROM timesheet;

-- Date and Time Functions
SELECT first_name, last_name, dob, YEAR(dob), WEEKDAY(dob), DAYOFWEEK(dob) from people;
SELECT emp_id, DATE(clock_in), TIME(clock_in) FROM timesheet; 

-- DATEFORMAT(argument, specifier) refer to doc for specifiers
SELECT emp_id, dob, DATE_FORMAT(dob, '%W %b %e, %Y') FROM people;

-- Date Math Functions
SELECT emp_id, DATEDIFF(curdate(), hire_date) AS days_post_hire FROM people;
SELECT DATE_ADD(hire_date, INTERVAL 1 YEAR) from people;

SELECT
DATE_ADD(dob, INTERVAL 18 YEAR) as voting_date,
DATE_ADD(dob, INTERVAL 21 YEAR) as legal_bdate from people;

SELECT TIMEDIFF(NOW(), clock_in) AS elapsed from timesheet
WHERE emp_id = 6;

SELECT first_name, dob, YEAR(dob + INTERVAL 21 YEAR) AS legal_after FROM people;

-- TIMESTAMP has same format as DATETIME, uses less memory, has limited date range
-- using ON UPDATE to track any changes to the table
CREATE TABLE people2 (
	emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    hire_date DATE NOT NULL,
    wage DECIMAL(5,2) NOT NULL,
    position VARCHAR(10) NOT NULL,
    last_updated TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    
INSERT INTO people2 (first_name, last_name, dob, hire_date, wage, position) VALUES
('Laura', 'Miller', '1980-01-01', '2020-01-01', 15.50, 'stock'),
('Jane', 'Austen', '1985-01-01', '2022-03-01', 14.50, 'stock'),
('Murphy', 'Smith', '1990-01-01', '2020-02-01', 15.50, 'sales'),
('Stu', 'Pendous', '1999-01-01', '2022-06-01', 13.50, 'sales'),
('Penny', 'Dollar', '1975-01-01', '2019-01-01', 25.50, 'manager');

SELECT * FROM people2;

UPDATE people2 SET wage='16.00' WHERE emp_id=1;

-- UNIT 10 exercise code
CREATE TABLE inventory (
	item_name VARCHAR(25),
	price DECIMAL(10,2),
    quantity INT);
    
SELECT CURTIME(), CURDATE();

SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;

SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');

CREATE TABLE tweets (
	content VARCHAR(180),
    username VARCHAR(20),
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
INSERT INTO tweets (content, username) VALUES
('first tweet', 'wilson123');

SELECT * FROM tweets;    





    
    
    