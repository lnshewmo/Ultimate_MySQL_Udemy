-- aggregate functions --> first group by criteria, then perform operation

-- aggregate fx COUNT
use bookshop;

DESC books;

SELECT COUNT(*) from books;  -- count of all rows

SELECT COUNT(title) from BOOKS WHERE title LIKE '%er%';

SELECT COUNT(DISTINCT author_lname) FROM books;

-- COUNT with GROUP BY
SELECT author_lname, COUNT(*) AS num_titles FROM books
	GROUP BY author_lname  ORDER BY author_lname;
    
SELECT author_fname, author_lname, COUNT(*) as num_titles FROM books
	GROUP BY author_lname, author_fname ORDER BY author_lname;
    
SELECT CONCAT(author_fname, ' ', author_lname) AS name, COUNT(*) as num_titles FROM books
GROUP BY author_lname, author_fname ORDER BY author_lname;

SELECT author_lname, COUNT(*) as num_titles FROM books
	GROUP BY author_lname, author_fname;
    
-- MIN and MAX are aggregate fx
SELECT MIN(released_year) FROM books;

-- one way to find max pages and title
-- only returns one row
SELECT title, pages FROM books
	ORDER BY pages DESC LIMIT 1;

-- same result using a subquery
-- subquery runs first
-- this will return all the rows when there are multiple
SELECT title, pages FROM books
	WHERE pages = (SELECT MAX(pages) FROM books);
    
INSERT INTO books (title, pages) VALUES ('my life in words', 634);

SELECT title, released_year FROM books
	WHERE released_year = (SELECT MIN(released_year) FROM books);
    
SELECT author_fname, author_lname, COUNT(*) FROM books
	GROUP BY author_lname, author_fname;
    
SELECT CONCAT(author_fname, ' ', author_lname) as author, COUNT(*) FROM books
	group by author;
    
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author_name,
    MIN(released_year) AS first_release,
    MAX(released_year) AS recent_release,
    COUNT(*) AS num_titles
FROM
    books
GROUP BY author_lname, author_fname
ORDER BY author_lname;

-- aggregate fx SUM() and AVG

SELECT author_lname, SUM(pages) FROM books
GROUP BY author_lname, author_fname;

SELECT author_lname, AVG(pages) FROM books
	group by author_lname;

-- agg fx exercises    
SELECT COUNT(*) as num_titles FROM books;

SELECT released_year, COUNT(*) as num_titles FROM books
	GROUP BY released_year ORDER BY released_year DESC;
    
SELECT SUM(stock_quantity) AS total_stock FROM books;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, AVG(released_year) FROM books
	GROUP BY author;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, pages FROM books
	ORDER BY pages DESC LIMIT 1;
    
SELECT CONCAT(author_fname, ' ', author_lname) AS author, pages FROM books
	WHERE pages = (SELECT MAX(pages) FROM books);
    
SELECT 
    released_year AS year,
    COUNT(title) AS '# books',
    AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year
ORDER BY released_year ASC;

SELECT * FROM books;

UPDATE books SET author_fname='Laura', author_lname='Miller', released_year=2023, stock_quantity=1 WHERE book_id = 20;



	


