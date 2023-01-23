-- aggregate functions --> first group by criteria, then perform operation

-- aggregate fx COUNT
use bookshop;

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


