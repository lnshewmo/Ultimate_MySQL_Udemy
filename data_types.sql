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

SELECT * FROM people;

CREATE TABLE timesheet (
emp_id INT NOT NULL PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
clock_in DATETIME,
clock_out DATETIME
);

DESC timesheet;



    
    
    