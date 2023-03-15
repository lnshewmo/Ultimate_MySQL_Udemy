-- CONSTRAINTS are rules or limitations which function to ensure accuracy and reliability of the data in a table
	-- ex. NOT NULL
    
-- UNIQUE (primary keys are alway unique)

use pet_shop;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(25) NOT NULL,
    shipping_address VARCHAR(200)
);

INSERT INTO customers (F_name, L_name, phone, email, shipping_address)
VALUES ('Bob', 'Franks', '8781213455', 'bobfranks12@yahoo.com', '1234 Easy Street, Bismark, Nevada, 12345');
 
-- This results in an error: Error Code: 1062. Duplicate entry '8781213455' for key 'customers.phone'
INSERT INTO customers (F_name, L_name, phone, email, shipping_address)
VALUES ('Bob', 'Franks', '8781213455', 'bobfranks12@yahoo.com', '1234 Easy Street, Bismark, Nevada, 12345');

-- CHECK (custom constraint)

CREATE TABLE users (
	username VARCHAR(20) NOT NULL UNIQUE,
    age INT CHECK (age>18)
    );
   
INSERT INTO users (username, age) VALUES
('redwagon5', 21),
('secondshell3', 17),
('bananapeelZ', 18);    -- Error Code: 3819. Check constraint 'users_chk_1' is violated.

SELECT * FROM users;    -- nothing was added to the table

CREATE TABLE palindromes (
	word VARCHAR(100) CHECK(REVERSE(word) = word)
    );
    
insert INTO palindromes (word) VALUES
	('big');			-- Error Code: 3819. Check constraint 'palindromes_chk_1' is violated.
    
-- NAMED CONSTRAINTS

CREATE TABLE users2 (
	username VARCHAR(20) NOT NULL UNIQUE,
    age INT,
    CONSTRAINT age_over_18 CHECK (age>18)
    );
    
INSERT INTO users2 (username, age) VALUES
	('chickenlady', 9);		-- Error Code: 3819. Check constraint 'palindromes_chk_1' is violated.

CREATE TABLE palindromes2 (
	word VARCHAR(100),
    CONSTRAINT must_be_palindrome CHECK(REVERSE(word) = word)
    );
    
insert INTO palindromes2 (word) VALUES
	('trucks');			-- Error Code: 3819. Check constraint 'must_be_palindrome' is violated.

CREATE TABLE vendors (
	first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    company VARCHAR(25) NOT NULL,
    address VARCHAR(25) NOT NULL,
    CONSTRAINT name_address_unique UNIQUE (first_name, last_name, address)  -- adding this constraint makes these primary keys
);

INSERT INTO vendors (first_name, last_name, company, address) VALUES
('Reggie', 'Sherman', 'Hooli', '456 Main Street');

INSERT INTO vendors (first_name, last_name, company, address) VALUES
('Reggie', 'Sherman', 'Big Box', '456 Main Street');  -- Error Code: 1062. Duplicate entry 'Reggie-Sherman-456 Main Street' for key 'vendors.name_address_unique'

CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

-- ALTER TABLE ---------------------------------------------------
SELECT * FROM vendors;

-- ADD/DROP COLUMN
ALTER TABLE vendors
ADD COLUMN phone VARCHAR(15) NOT NULL DEFAULT '0000000000';  -- the rows already in the table have NULL values unless a DEFAULT is specified

ALTER TABLE vendors
ADD COLUMN email VARCHAR(25) NOT NULL;  -- the rows already in the table have empty strings

ALTER TABLE vendors
DROP COLUMN phone; 

-- 2 WAYS TO RENAME A TABLE
RENAME TABLE vendors TO suppliers;
ALTER TABLE suppliers RENAME TO vendors;

-- RENAME COLUMN
ALTER TABLE vendors
RENAME COLUMN phone TO telephone;

DESC vendors;

-- MODIFY COLUMN
DESC customers;

ALTER TABLE customers
MODIFY shipping_address VARCHAR(100) DEFAULT 'unknown';  -- modify data type ONLY and added default value

INSERT INTO customers (F_name, L_name, phone, email) VALUES
('Chris', 'Mass', '8675309001', 'xmas25@earthlink.net');

SELECT * FROM customers;

-- CHANGE COLUMN
ALTER TABLE customers
CHANGE shipping_address street_address VARCHAR(50) NOT NULL;  -- changed name AND data type simultaneously

-- ADD CONSTRAINT
DESC houses;

ALTER TABLE houses ADD CONSTRAINT positive_value CHECK (purchase_price>=0);

INSERT INTO houses (purchase_price, sale_price) VALUES (-1,4);  -- Error Code: 3819. Check constraint 'positive_value' is violated.

ALTER TABLE houses DROP CONSTRAINT positive_value;

SHOW CREATE TABLE houses;  -- displays the SQL to recreate the table in its current form, can see constraints
SHOW CREATE TABLE vendors;
