# Ultimate_MySQL_Udemy_Course

SQL files for coding along with 'The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert'

1 - **Getting Started Sections 1-2**

MySQL is an open source (relational) database management system developed by Oracle Corp.

  Installation: version 8.0

  three ways to interact with the database server:
  - from gitbash type:  mysql -u root -p
  - MySQL Command Line Client 
  - MySQL Workbench app

2 - **Section 3: Databases, Tables, Data Types**

* SHOW DATABASES;
* CREATE DATABASE <db_name>;
* DROP DATABASE <db_name>;
* USE <db_name>;
* CREATE TABLE <table_name> (col1 dtype1 DEFAULT NOT NULL AUTO_INCREMENT PRIMARY KEY);
* SHOW tables;
* SHOW COLUMNS FROM <table_name>;
* DESC <table_name>;
* DROP TABLE <table_name>;

3 - **Sections 4-5: Inserting Data, CRUD Basics**
CRUD stands for CREATE, READ, UPDATE, DELETE.

Table properties are assigned at creation to define properties, constraints, default values and key relationships.  

* INSERT INTO <table_name> (col1, col2) VALUES (value1, 'value2');
* SELECT * FROM <table_name> AS alias;
* WHERE clause
* UPDATE <table_name> SET var1=value1 WHERE var2=value2;
* DELETE FROM <table_name> WHERE var1=value1;
* DELETE FROM <table_name>;  **deletes all rows from the table**

4 -**Section 7: String Functions**

* CONCAT()
* SUBSTRING()
* REPLACE()
* REVERSE()
* CHAR_LENGTH()
* UPPER() and LOWER()
* LEFT() and RIGHT()
* REPEAT()
* TRIM()

5 -**Sections 8-9: Refining Queries**
* DISTINCT, ORDER BY, LIMIT, LIKE
* Aggregate functions with GROUP BY, MIN, MAX, SUM, AVG

6 -**Section 10: Deeper in Data Types**
* 

7 -**Section 11: Comparison & Logical Operators**
* 

8 -**Section 12: Constraints and ALTER TABLE**
* 

9 -**Sections 13-14: Joins**
* 

10 -**Section 15: Views, Modes & More**
* 

11 -**Section 16: Window Functions**
* 

12 -**Sections 17-18: Instagram Data Example**
* 

13 -**Legacy Sections: Building a Webapp using Node and GoormIDE**
* instructions for sourcing a SQL file inside a GoormIDE contaner (https://www.youtube.com/watch?v=DjhthBTXvXg)
* open the MySQL command line from the same directory where your .SQL lives in order to source it easily in GoormIDE
  * @Terminal (mysql-ctl cli)
  * source file_name.sql
