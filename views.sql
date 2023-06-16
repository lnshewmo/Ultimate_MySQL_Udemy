-- Using Views
-- from documentation: views are stored queries that when invoked produce a result set, a virtual table

USE tv_reviews;

SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

SHOW tables;  -- full_reviews appears in the tables list

SELECT * FROM full_reviews WHERE genre = 'Animation';

SELECT genre, ROUND(AVG(rating),2) FROM full_reviews GROUP BY genre;

-- updateable views
DELETE FROM full_reveiews WHERE released_year = 2010;  -- Error Code: 1146. Table 'tv_reviews.full_reveiews' doesn't exist
-- not permitted bc this view is created by joins; see docs which views can be updated

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;  -- no joins in this view

SELECT * FROM ordered_series; 

INSERT INTO ordered_series (title, released_year, genre)
VALUES ('The Great', 2020, 'Comedy');

SELECT * FROM series; -- values were inserted in the both the VIEW AND series table ALSO
 
-- how to alter an existing view
-- option A
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
-- option B
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

DROP VIEW ordered_series;

-- GROUP BY __ HAVING: specifies a condition on GROUPS
-- WHERE clause doesn't filter on groups
SELECT 
	title, 
    ROUND(AVG(rating),2) AS AVG,
    COUNT(rating) AS COUNT
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

-- GROUP BY __ WITH ROLLUP clause: a modifier that causes aggregate summary output to include extra rows of higher-level aggregate operation
SELECT title, ROUND(AVG(rating), 2) AS AVG FROM full_reviews
GROUP BY title WITH ROLLUP;  -- the resulting table shows the avg for titles, followed by last row 'null' containing avg for all (ungrouped) titles

SELECT title, COUNT(rating) AS num_reviews FROM full_reviews
GROUP BY title WITH ROLLUP;

-- ROLLUP on multiple groups
-- gets avg summary at 3 levels:  by genre for each year, by only year, by overall
SELECT genre, released_year, AVG(rating) FROM full_reviews GROUP BY released_year, genre WITH ROLLUP;

-- SQL MODES:  modes affect the SQL syntax MySQL supports and the data validation checks it performs

-- to view modes:
SELECT @@GLOBAL.sql_mode;  -- permanent settings for all users, all sessions.  typically not changed.
SELECT @@SESSION.sql_mode;  -- setting modes for current session.  resets to global when the session is closed.

-- current settings: ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

SELECT 3/0;
SHOW WARNINGS;

-- to set modes:
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';

-- setting: STRICT_TRANS_TABLES (it will abort/error the action if the action violates the table definitions)
	-- turning this setting off would permit data to be inserted into the table in violation of the table definitions = BAD
	-- for example, string could be entered into an INT field
    
-- NO_ZERO_IN_DATE: disable this setting and dates with '00' can be inserted in the table
