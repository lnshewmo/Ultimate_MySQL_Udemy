CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(25) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    middle_name VARCHAR(25),
    age INT NOT NULL,
    current_status VARCHAR(20) NOT NULL DEFAULT 'employed'
);

select database();
desc employees;
select * from employees;
drop table employees;

use pet_shop;
insert into cats (name, age)
values ('Jetson', 2);
insert into cats (name, age) values ('shmitty', 13);
insert into cats (name, age) values ("meatball", 5), ("Turkey",3);
SELECT * FROM cats;

create table people  (
first_name VARCHAR(25),
last_name VARCHAR(25),
age INT);

desc people;

insert into people( first_name, last_name, age) values ("Tina","Belcher", 13);
INSERT INTO people (first_name, last_name, age) VALUES ("Bob", "Belcher", 52),("Linda","Belcher", 46), ("Gene", "Belcher", 11);
SELECT * FROM people;

CREATE TABLE cats2 (
name VARCHAR(25) NOT NULL,
age INT NOT NULL
);

SELECT * from cats2;
DESC cats2;

CREATE TABLE shops (
name VARCHAR(25));

INSERT INTO shops (name) VALUES ('mario\'s pizza');

SELECT * FROM shops;

create table cats3 (
name VARCHAR(50) DEFAULT 'unknown',
age INT default 99);

INSERT INTO cats3 (age) VALUES();
SELECT * FROM cats3;

drop table cats2;

select * from cats;

CREATE TABLE products (
id INT NOT NULL primary key,
name VARCHAR(25) NOT NULL,
price int);

create table cats (
cat_id int auto_increment PRIMARY KEY,
name varchar (100),
breed varchar(100),
age INT
);

insert into cats (name, breed, age)
values ('Ringo','Tabby',4), 
		('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);
       
select * from cats WHERE age=4;
select name from cats;

update cats set age=14 where name ='misty';
select * from cats;

