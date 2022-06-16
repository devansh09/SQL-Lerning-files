CREATE DATABASE IF NOT EXISTS Sales;
use sales;

CREATE TABLE customers                                                 
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);

drop sales;

Create table sales
(
purchase_number int auto_increment,
date_of_purchase date,
customer_id int,
item_code varchar(10),
Primary key (purchase_number),
foreign key (customer_id) references customers(customer_id) on delete cascade
);

drop table sales;

Create table sales
(
purchase_number int auto_increment,
date_of_purchase date,
customer_id int,
item_code varchar(10),
Primary key (purchase_number)
);

alter table sales
add foreign key (customer_id) references customers(customer_id) on delete cascade;

alter table sales
drop foreign key sales_ibfk_2;

alter table sales
drop foreign key sales_ibfk_1;

drop table sales;
drop table customers;
drop table items;
drop table companies;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

alter table customers
change column number_of_complaints number_of_complaints int default 0;

insert into customers (first_name, last_name, gender)
values ('Peter', 'Figaro', 'M');

select * from customers;

create table companies (
company_id varchar(255),
company_name varchar(255) Default 'X',
headquarter_phone_number varchar(255),
Unique key (headquarter_phone_number)
);

drop table companies;

Alter table companies
modify column headquarter_phone_number varchar(255) Null;

Alter table companies
change column headquarter_phone_number headquarter_phone_number varchar(255) Not Null;

Use employees;
select dept_no from departments;

select * from departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
Select * from employees
where gender = 'f' and first_name ='Kellie'; 

SELECT * FROM employees
where first_name = 'Aruna' OR first_name = 'Kellie';

SELECT * FROM employees
where gender = 'f' and (first_name = 'Aruna' OR first_name = 'Kellie');

select * from employees
where first_name in ('Denis', 'Elvis');

select * from employees
where first_name not in ('John','Mark','Jacob');


select * from employees
where first_name like ('mark%');

select * from employees
where hire_date like ('%2000%');

select * from employees
where emp_no like ('1000_') ;


