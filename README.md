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
