-- STRING FUNCTIONS to Aggregate fx
create database bookshop;
use bookshop;
DROP TABLE books;

CREATE TABLE books (
		book_id INT AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

select * from books;

select concat(author_fname, ' ', author_lname) as author_fullname from books;

-- concat_ws WITH SEPARATOR (separator, col1, col2)
SELECT concat_ws(' ', author_fname, author_lname) as author_fullname from books ;

-- dynamic substring() used with concat()
-- substr(col, start, end)

SELECT CONCAT(
        SUBSTRING(title, 1, 15),
        '...'
    ) AS 'short title'
FROM books;

select substr(author_fname, 1,1) as initial, author_lname from books;

SELECT SUBSTR(title, 1,10) from books;

SELECT CONCAT(SUBSTR(title, 1,10), '...') as short_title from books;

-- use whitespace to better illustrate nesting
SELECT 
    CONCAT(SUBSTR(author_fname, 1, 1),
            '.',
            SUBSTR(author_lname, 1, 1),
            '.') AS initials
FROM
    books;

-- replace(element, what_from_element, to_str)
SELECT REPLACE(title, ' ', '_') from books;

SELECT REPLACE(title, 'e', '3') from books;

-- reverse(string);
SELECT REVERSE(title) as bass_akward from books;

SELECT CONCAT(author_fname, REVERSE(author_fname)) from books;

-- char_length()
SELECT char_length(title) as len, title from books;

-- upper() or ucase() and lower() or lcase() changes the case of the string
SELECT UCASE(title) from books;

SELECT UPPER(
	CONCAT('I love ', title, ' !!!'))
from books;

SELECT UPPER(
	CONCAT_WS(' by: ', title, author_lname)) from books;
    
-- insert(str, pos, len, new_str)
SELECT INSERT(title, 1, 0, '***') as inserted from books;

-- left() right()
SELECT LEFT(title, 5) from books;

SELECT CONCAT_WS(' ', LEFT(author_fname, 1), LEFT(author_lname, 1)) AS author_initials from books;

-- repeat()
SELECT REPEAT(title, 2) from books;

-- trim()  remove leading and trailing spaces not middle spaces
SELECT TRIM('   boston ');
SELECT TRIM(LEADING '.' FROM '....san antonio...');
SELECT TRIM(TRAILING '.' FROM '....san antonio...');
SELECT TRIM(BOTH '.' FROM '....san...antonio...');

-- exercises
SELECT UPPER(REVERSE('abcdefghijklmmopqrstuvwxyz'));

SELECT REPLACE(
	CONCAT('I', ' ', 'like', ' ', 'dogs'),
    ' ',
    '_') as dogs;
    
SELECT REPLACE(title, ' ', '->') as title from books;

SELECT author_lname as forwards, REVERSE(author_lname) as backwards from books;

SELECT DISTINCT UPPER(CONCAT(author_fname, ' ', author_lname)) as 'full name in caps' from books;

SELECT CONCAT(title, ' was released in ', released_year) as blurb from books;

SELECT title, length(title) as 'character count' from books;

SELECT 
    CONCAT(LEFT(title, 10), '...') AS 'short title',
    CONCAT(author_lname, ', ', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM
    books
ORDER BY title ASC;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
           
SELECT * FROM books;

------- OPERATORS -------
-- DISTINCT clause eliminates duplicates
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) as author_list from books;
SELECT DISTINCT author_fname, author_lname, released_year from books;

-- ORDER BY clause sets the order of the returned table
SELECT DISTINCT author_lname, author_fname FROM books ORDER BY author_lname;

-- ORDER BY using column# or second item selected
SELECT book_id, author_fname, author_lname, pages from BOOKS
	order by 2 desc;

-- ORDER BY using multiple columns    
SELECT author_lname, released_year, title from BOOKS
	ORDER BY author_lname, released_year DESC;  -- default is ASC, can specify

-- sorting by alias    
SELECT concat(author_fname, ' ', author_lname) AS author from BOOKS
	ORDER BY author;  
    
-- LIMIT is most effective following a sort.  similar to head() python
SELECT book_id, title, released_year from BOOKS 
	ORDER BY released_year DESC LIMIT 5;
    
SELECT book_id, title, released_year from BOOKS 
	ORDER BY released_year DESC LIMIT 1,5;  -- start at row 1, go next 5 

-- it will return as much as is in the table
SELECT * from tbl LIMIT 100;

SELECT title, author_fname from BOOKS where author_fname='David';

-- using % wildcard -- > 'optionally 0 or more characters'
SELECT title, author_fname from BOOKS where author_fname LIKE '%da%';

SELECT * from books where title LIKE '%:%';

-- underscore is an exact placeholder
-- this is only 4 character first names
SELECT * from BOOKS WHERE author_fname LIKE '____';  

-- all names ending in n
SELECT * from BOOKS WHERE author_fname LIKE '%n';

-- using backslash to escape character
SELECT * from BOOKS WHERE title LIKE '%\%%';

SELECT title from BOOKS WHERE title LIKE '%stories%';

SELECT title, pages from BOOKS
	ORDER by pages DESC LIMIT 1;

SELECT CONCAT(title, ' - ', released_year) AS summary from BOOKS
	ORDER BY released_year DESC LIMIT 3;
    
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

SELECT title, released_year, stock_quantity FROM BOOKS
	order by stock_quantity LIMIT 3;
    
SELECT title, author_lname FROM BOOKS
	ORDER BY author_lname, title;
    
SELECT 
    UPPER(CONCAT('my favorite author is ',
                    author_fname,
                    ' ',
                    author_lname,
                    '!')) AS YELL
FROM BOOKS ORDER BY author_lname;
