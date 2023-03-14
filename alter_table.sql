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
    CONSTRAINT name_address_unique UNIQUE (first_name, last_name, address)
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