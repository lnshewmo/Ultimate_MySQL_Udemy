-- COMPARISION AND LOGICAL OPERATORS
use bookshop;

-- NOT EQUAL !=
SELECT book_id, title, author_lname FROM books WHERE author_lname = 'Gaiman';
SELECT book_id, title, author_lname FROM books WHERE author_lname != 'Gaiman';
SELECT * FROM books WHERE released_year != 2017;

-- NOT LIKE
SELECT title FROM books WHERE title NOT LIKE '% %'; -- no spaces in the title
SELECT * FROM books WHERE author_fname NOT LIKE '%da%';
SELECT title FROM books WHERE title NOT LIKE '%e%'; -- does not contain e

-- GREATER THAN >
SELECT * FROM books WHERE released_year > 2005; -- not inclusive, use >=
SELECT * FROM books WHERE pages > 500;

	-- sidebar: Booleans
	SELECT 80>40; -- returns 1 for TRUE
	SELECT 80>100; -- returns 0 for FALSE
	-- the query only returns rows from the where statement which are true.  nulls excluded.
	SELECT * FROM books;
    UPDATE books SET pages = NULL WHERE book_id = 20;
	SELECT * FROM books WHERE pages > 200;

-- LESS THAN <
SELECT * FROM books WHERE released_year < 2000
ORDER BY released_year DESC;

SELECT * FROM books WHERE released_year <=2000  -- inclusive of 2000
ORDER BY released_year DESC;

-- LOGICAL 'AND'  both LEFT AND RIGHT condition must be true

SELECT 1>0 -- LEFT SIDE
AND 8=0;  -- RIGHT SIDE

SELECT * FROM books 
WHERE author_lname ='Eggers' 
AND released_year > 2010 
ORDER BY released_year DESC;

SELECT * FROM books 
WHERE author_lname ='Eggers' 
AND released_year > 2010
AND title LIKE '%novel%'
ORDER BY released_year DESC;

SELECT title, pages FROM books 
WHERE CHAR_LENGTH(title) >30
AND pages > 500;

-- LOGICAL OR  either LEFT OR RIGHT can be true
SELECT * FROM books 
WHERE author_lname ='Eggers' 
OR released_year > 2010 
ORDER BY released_year DESC;

SELECT title, pages FROM books
WHERE pages <200
OR title LIKE '%stories%';

-- BETWEEN
SELECT * FROM books
WHERE released_year BETWEEN 2004 AND 2014;  -- inclusive of both sides

-- NOT BETWEEN
SELECT title, pages FROM books 
WHERE pages NOT BETWEEN 198 AND 300;  -- inclusive both sides

-- comparing dates
USE pet_shop;
-- these extract the same things but
SELECT * from people WHERE dob < '1995-01-01';  -- in this case dob treated as string
SELECT * from people WHERE YEAR(dob) < 1995; -- in this case dob treated as time value

	-- sidebar: CAST('string' AS type [ARRAY])
    SELECT CAST('9:00:00' AS TIME);
    
SELECT * FROM people WHERE dob 
BETWEEN CAST('1990-01-01' AS DATE) AND
CAST('1999-01-01' AS DATE);

SELECT * FROM people WHERE YEAR(dob)
BETWEEN 1990 AND 1999;

-- LOGICAL IN
USE bookshop;
SELECT * FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT * FROM books
WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

-- USING MODULO to get all odd book_ids
SELECT * FROM books 
WHERE book_id % 2 = 1; 

-- CASE statements
SELECT title, released_year,
CASE
	WHEN released_year >= 2000 THEN 'Modern Literature'
    ELSE '20th Century Literature'
END AS genre
FROM books;

SELECT title, stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
        ELSE '****'
    END AS stock
FROM books;

-- case is evaluated top down and stops at the first true condition, so...
SELECT title, stock_quantity,
    CASE
        WHEN stock_quantity <= 40 THEN '*'
        WHEN stock_quantity <= 70 THEN '**'
        WHEN stock_quantity <= 100 THEN '***'
        ELSE '****'
    END AS stock
FROM books;

-- IS NULL, IS NOT NULL
SELECT * FROM books WHERE title IS NOT NULL;

-- Section 11 Exercise
SELECT * FROM books WHERE released_year < 1985;

SELECT * FROM books WHERE author_lname IN ('Eggers', 'Chabon');

SELECT * FROM books 
	WHERE author_lname ='Lahiri' AND
    released_year > 2000;
    
SELECT * FROM books 
	WHERE pages BETWEEN 100 AND 200;

SELECT * FROM books
	WHERE author_lname LIKE 'C%'
	OR author_lname LIKE 'S%';
    
SELECT title, author_lname, SUBSTR(author_lname, 1, 1) AS FI FROM books
	WHERE SUBSTR(author_lname, 1, 1) IN ('C', 'S');
    
SELECT title, author_lname, 
CASE
	WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
    ELSE 'Novel'
END AS type
FROM books;

SELECT author_fname, author_lname, 
	CASE 
		WHEN COUNT(*) = 1 THEN '1 book'
		ELSE CONCAT(COUNT(*), ' books')
	END AS COUNT 
FROM books
GROUP BY author_fname, author_lname;

