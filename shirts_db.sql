-- create database shirts_db;
-- use shirts_db;

-- create table shirts 
-- (shirt_id int auto_increment PRIMARY KEY,
-- article varchar(25), 
-- color varchar(25),
-- shirt_size varchar(5),
-- last_worn int);

-- desc shirts;

-- insert into shirts (article, color, shirt_size, last_worn)
-- values ('t-shirt', 'white', 'S', 10),
-- 	('t-shirt', 'green', 'S', 200),
-- 	('polo shirt', 'black', 'M', 10),
-- 	('tank top', 'blue', 'S', 50),
-- 	('t-shirt', 'pink', 'S', 0),
-- 	('polo shirt', 'red', 'M', 5),
-- 	('tank top', 'white', 'S', 200),
-- 	('tank top', 'blue', 'M', 15);
--     
select*from shirts;
   
insert into shirts (article, color, shirt_size, last_worn)
    values ('polo shirt', 'purple', 'M', '50');
    
select article, color from shirts;
    
select article, color, shirt_size, last_worn from shirts where shirt_size='M';
    
update shirts set shirt_size ='L' where article='polo shirt';
    
update shirts set last_worn=0 where last_worn=15;
    
update shirts set shirt_size='XS', color='off white' where color='white';
    
delete from shirts where last_worn=200;
    
delete from shirts where article='tank top';

delete from shirts;

drop table shirts;
desc shirts;