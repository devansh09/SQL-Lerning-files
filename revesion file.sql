use employees;

select * from employees
where first_name IN ('cathie', 'Mark', 'nathan');

select * from employees
where first_name NOT IN ('cathie', 'Mark', 'nathan');

select * from employees
where first_name LIKE('Mar%');

select * from employees
where first_name LIKE('%ar%');

select * from employees
where first_name LIKE('Mar_');

select * from employees
where first_name NOT LIKE('Mar_'); #case insensetive mar, MAR and Mar all are same here.

select * from employees
where hire_date like('%2000%');

select * from employees
where emp_no like('1000_');

select trim("   You are best   ") as TrimString;

select distinct first_name, substr(first_name,2,3)
from employees
where emp_no not like('100%');

select Locate('b', first_name) #gives the index of the searched string
from employees; 

select substr(first_name, 1, Locate('s', first_name)) as shortname #little complex query: it will display name from starting to the the index where 's' is found. 
from employees
where emp_no not like('100%');

select * from salaries
where salary between 60000 and 77000;

select * from employees
where first_name is null;

select dept_name
from departments
where dept_no is not null;

select * from employees
where gender = 'f' and hire_date >= '2000-01-01';

select distinct gender 
from employees;

select distinct hire_date
from employees
Limit 20;

#How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
Select count(*)
from salaries
where salary > 100000;

#How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
select count(*)
from dept_manager;

select * from employees
order by hire_date desc;


#Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
#The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
#Lastly, sort the output by the first column.

SELECT salary, count(emp_no) as emps_with_same_salary
from salaries
where salary > 80000
group by salary
order by salary;

#Select all employees whose average salary is higher than $120,000 per annum.
select * , avg(salary) as avg_salary
from salaries
group by emp_no
having avg(salary) > 120000
order by emp_no;



select first_name, count(first_name) as names_count
from employees
where hire_date > '1999-01-01'
group by first_name
having count(first_name)<200
order by first_name;

#Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
select *, count(dept_no)
from dept_emp
where from_date>'2000-01-01'
group by emp_no
having count(dept_no) > 1
order by emp_no;

#Select the first 100 rows from the ‘dept_emp’ table. 
select * from dept_emp
limit 100;

select round(avg(salary),1)
from salaries
where from_date>'2000-01-01';

#temporary setup departments_dup to work on if null and coalesce
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

SELECT * FROM
departments_dup
ORDER BY dept_no ASC;

insert into departments_dup
(
dept_no,
dept_name
)
Select * from departments;

select * from departments_dup;

select dept_no, IFNULL(dept_name, 'dept name not provided') as departmen_name
from departments_dup;

#coalesce is similar to ifnull but it can have more than 2 arguments

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

select dept_no, coalesce(dept_manager, dept_name,'NA') as dept_manager
from departments_dup;

#coalsece and ifnull only create an output. They dont alter with the original data of the table

#Q: Select the department number and name from the ‘departments_dup’ table and add a third column 
#where you name the department number (‘dept_no’) as ‘dept_info’. If ‘dept_no’ does not have a value, use ‘dept_name’.

select dept_no, dept_name, coalesce(dept_no, dept_name) as dept_info
from departments_dup;

#Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function to the values from the first and second column, 
#so that ‘N/A’ is displayed whenever a department number has no value, and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.

select ifnull( dept_no, 'NA'), ifnull(dept_name, 'dept name not provided')
from departments_dup;

SELECT
    IFNULL(dept_no, 'N/A') as dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no ASC;

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

select * from departments_dup;

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

 
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                                (999905, '2017-01-01'),
                               (999906, '2017-01-01'),
                               (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');
 
DELETE FROM departments_dup
WHERE dept_no = 'd002'; 

#Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 

select e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
from employees e
inner join dept_manager m on e.emp_no = m.emp_no;

#left join

select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
LEFT JOIN
departments_dup d on m.dept_no = m.dept_no
order by m.dept_no;

#swap the tables and output will be different for left and right join
select m.dept_no, m.emp_no, d.dept_name
from departments_dup d
LEFT JOIN
dept_manager_dup m on m.dept_no = m.dept_no;

#we can use LEFT OUTER JOIN instead of LEFT JOIN

#if we want result where we don't want the matched or common data. we can do like this 
select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
LEFT JOIN
departments_dup d on m.dept_no = m.dept_no
where 
dept_name is null
order by m.dept_no;

#Q: Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
#See if the output contains a manager with that name.  


SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date 
from dept_manager m
left join employees e on e.emp_no = m.emp_no
where e.last_name ='Markovitch'
order by m.dept_no desc, e.emp_no;


#Q: Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
#Use the old type of join syntax to obtain the result.

select e.*,dm.*
from 
dept_manager_dup dm,
employees e
where dm.emp_no = e.emp_no;

#new syntax
select e.*,dm.*
from 
dept_manager_dup dm
join
employees e on dm.emp_no = e.emp_no;

#ignore it just updating a setting
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

#Q: Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.

select e.first_name, e.last_name, e.hire_date, t.title
from employees e
join titles t on e.emp_no = t.emp_no
where e.first_name = 'Margareta'AND e.last_name = 'Markovitch'
order by e.first_name;

#Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
select dm.*, d.*
from dept_manager as dm
cross join
departments as d
where d.dept_no = 'd009'
order by d.dept_no;

#Return a list with the first 10 employees with all the departments they can be assigned to.

select e.*, d.*
from employees e
cross join
departments d
where e.emp_no< 10011
ORDER BY e.emp_no, d.dept_name;

#find average salary of men and women in the company
select e. gender, avg(s.salary)
from salaries s
join 
employees e on s.emp_no = e.emp_no
group by e.gender;

#Select all managers’ first and last name, hire date, job title, start date, and department name.

Select e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
from dept_manager dm
join employees e on e.emp_no = dm.emp_no
join titles t on t.emp_no = e.emp_no
join departments d on d.dept_no = dm.dept_no
where t.title='Manager'
ORDER BY e.emp_no;

SELECT e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

#obtain the names of all departments and calculate the average salary paid to the managers in each of them

select d.dept_name, avg(s.salary) as average_salary, t.title
from
departments d 
join
dept_manager m on m.dept_no = d.dept_no
join 
salaries s on s.emp_no = m.emp_no
join
titles t on t.emp_no = m.emp_no
where t.title = 'Manager'
group by d.dept_name
order by average_salary desc;

select d.dept_name, avg(s.salary) as average_salary
from
departments d 
join
dept_manager m on m.dept_no = d.dept_no
join 
salaries s on s.emp_no = m.emp_no
group by d.dept_name
having average_salary > 60000   #to find if avg salary os greater than 60000
order by average_salary desc;	

#How many male and how many female managers do we have in the ‘employees’ database?
select e.gender, count(m.emp_no) as Number_of_managers
from 
employees e 
join 
dept_manager m on e.emp_no = m.emp_no
group by e.gender;

#union vs union all: Use when you have to combine all data of 2 tables. both table have same columns therefore we are creating null columns in each table. 
#name and order of columns should also be same
#union all repeats if there is any duplicate and union will not repeat.

SELECT * FROM
    (SELECT e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' 
        UNION SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;

#sub queries
#Q: Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

select *
from employees e
where e.emp_no in (select emp_no 
from dept_manager) and hire_date between '1990-01-01' and '1995-01-01';

select e.* 
from employees e
join 
dept_manager m on e.emp_no = m.emp_no
where e.hire_date between '1990-01-01' and '1995-01-01';

#exist and Not exist
#Q: Select the entire information for all employees whose job title is “Assistant Engineer”. 

select *
from employees e
where EXISTS(select *
from
titles t
where t.emp_no = e.emp_no and title ='Assistant engineer'
);


#Starting your code with “DROP TABLE”, create a table called “emp_manager” (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). 

Drop table if exists emp_manager;
create table emp_manager(
emp_no int(11) not null,
dept_no char(4) null,
manager_no int(11) not null
);


SELECT 
    emp_no AS employee_ID,
    MIN(dept_no) AS department_code,
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 10022) AS manager_id
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no;
    
    
#views

#create view of employes for data comprising the last contract of each employeethe (hint: latest from and to date)


CREATE OR REPLACE VIEW v_dept_employee_latest_data AS
    SELECT 
        emp_no, dept_no, MAX(from_date), MAX(to_date)
    FROM
        dept_emp
    GROUP BY emp_no; 
    
select * from employees.v_dept_employee_latest_data;

#Q: Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.


create or replace view v_salaries_manager as
select round(avg(s.salary),2)
from 
salaries s
join 
dept_manager dm on s.emp_no = dm.emp_no;

select * from employees.v_salaries_manager;

#stored routines
#inside routines lies -> stored procedure and functions

#1. stored procedure
drop procedure if exists select_employees;

DELIMITER $$
create procedure select_employees()
begin
select * from employees
limit 100;

END $$
Delimiter ;

call employees.select_employees(); #

#Q: Create a procedure that will provide the average salary of all employees.

drop procedure if exists avg_salary;

DELIMITER $$
create procedure avg_salary()
BEGIN
select avg(salary)
from salaries;
END $$
DELIMITER ;

call employees.avg_salary();

#you can create stored procedure by right clicking on the stored procedure in the schema section
# you can also drop a procedure by right clicking on the procedure in the schema section

delimiter $$
create procedure emp_salary(IN p_emp_no integer)
begin
select e.emp_no, e.first_name, e.last_name, s.salary
from employees e
join 
salaries s on s.emp_no = e.emp_no
where
e.emp_no = p_emp_no;
end $$
delimiter ;

# you can execute this from schema section as well

call employees.emp_salary(11300);

delimiter $$
create procedure avg_salary_2(IN p_emp_no integer)
begin
select e.first_name, e.last_name, avg(s.salary)
from employees e
join
salaries s on e.emp_no = s.emp_no
where
e.emp_no = p_emp_no;
end $$
delimiter ;

#using out parameter
delimiter $$
create procedure avg_salary_out( IN p_emp_no integer, OUT p_avg_salary DECIMAL(10,2))
begin
select Avg(s.salary)
INTO p_avg_salary
from employees e
join
salaries s on e.emp_no = s.emp_no
where
e.emp_no = p_emp_no;
end $$
delimiter ;

# Q: Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.


drop procedure emp_info1;

delimiter $$
create procedure emp_info(in p_fname varchar(255), in p_lname varchar(255), out p_emp_no integer)
begin
select emp_no
into p_emp_no
from employees
where 
first_name = p_fname and last_name = p_lname;
end $$
delimiter ;

#variables

set @v_avg_salary = 0;
call  employees.avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

#Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise.

set @v_emp_no =0;
call employees.emp_info('Lillian','Fontet',@v_emp_no);
select @v_emp_no;


#user defined funcltions

delimiter $$
create function f_emp_avg_sal (p_emp_no INTEGER) Returns decimal(10,2)
deterministic no sql reads sql data
begin
declare v_avg_sal decimal(10,2);

select avg(s.salary)
into v_avg_sal
from employees e
join
salaries s on s.emp_no = e.emp_no
WHERE 
e.emp_no = p_emp_no; 
return v_avg_sal;
end $$
delimiter ;

#Q: Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee.

delimiter $$
create function emp_info( p_fname varchar(255), p_lname varchar(255)) returns decimal(10,2)
begin
declare v_max_sal decimal(10,2);

select salary
into v_max_sal
from (
select s.emp_no,e.first_name, e.last_name, max(s.from_date), max(s.to_date), s.salary
from salaries s
join employees e on e.emp_no = s.emp_no
group by emp_no
)
where e.first_name = p_fname and e.last_name = p_lname;
return v_max_sal;	

end$$
delimiter ;



delimiter $$
create function emp_info( p_fname varchar(255), p_lname varchar(255)) returns decimal(10,2)
deterministic no sql reads sql data
begin
declare v_max_sal decimal(10,2);
declare v_max_from_date date;

select max(from_date) into v_max_from_date
from employees e
join 
salaries s on s.emp_no = e.emp_no
where
e.first_name = p_fname and e.last_name = p_lname;

select s.salary
into v_max_sal
from salaries s
join
employees e on e.emp_no = s.emp_no
where
e.first_name = p_fname and
e.last_name = p_lname and
s.from_date = v_max_from_date;

return v_max_sal;	

end$$
delimiter ;

select emp_info('Aruna', 'journel');

#procedure is invoked by 'call' ||  function is ran by 'select' => thats why we can include a function as a column inside a statement 
#procedure can have both in and out parameters aslo they can have multiple out parameters || function can only return a single value

# if you want more than one returend value then use procedures else for 1 retun value use functions

#if you want to do 'insert' 'delete' and 'update' then use procedures without 'out' parameters because in functions we have to return something and in this case there is nothing to return


set @v_emp_no = 11300;
select emp_no, first_name, last_name, f_emp_avg_sal(@v_emp_no) as avg_salary
from employees
where emp_no = @v_emp_no;

#trigers

commit;

#before insert trigger

drop trigger if exists before_salary_insert;

delimiter $$
create trigger before_salary_insert
before insert on salaries
for each row
begin
if new.salary < 0 then
set new.salary = 0;
end if;
end $$
Delimiter ;

insert into salaries values('10001', -92999, '2010-06-22', '9999-01-01');

#before update trigger

drop trigger if exists before_salary_update;
delimiter $$
create trigger before_salary_update
before update on salaries
for each row
begin
if new.salary < 0 then
set new.salary = old.salary;
end if;
end $$
Delimiter ;

update salaries
set salary = -1000
where 
emp_no = 10001
and from_date = '2010-06-22';

select * from salaries
where emp_no = '10001';

delimiter $$
create trigger trig_ins_dept_man
after insert on dept_manager
for each row
begin
declare v_cur_sal integer;

select 
max(salary) into v_cur_sal 
from salaries
where emp_no = new.emp_no;

if v_cur_sal is not null then 
update salaries
set to_date = sysdate()
where emp_no = new.emp_no and to_date = new.to_date;

insert into salaries 
values(new.emp_no, v_cur_sal+20000, new.from_date, new.to_date);
end if;
end $$
delimiter ;

insert into dept_manager values('111534', 'd009', date_format(sysdate(),'%y-%m-%d'), '9999-01-01');

rollback;
#indexes

create index i_hire_date on employees(hire_date);

select * from employees
where hire_date > '2000-01-01';

#composite index
create index i_composite on employees(first_name, last_name);

select * from employees
where first_name = 'Georgi' and last_name='facello';

alter table employees
drop index i_hire_date;

#Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.

select * from salaries
where salary > 89000;

create index i_sal on salaries(salary);

select * from salaries
where salary > 89000;


alter table salaries
drop index i_sal;

#case statement

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
    
select e.emp_no, e.first_name, e.last_name,
case
when dm.emp_no is not null then "Manager"
else 'Employee'
end as job_role
from employees e
left join dept_manager dm on e.emp_no = dm.emp_no
where e.emp_no> 109990;

select emp_no, first_name, last_name,
if(gender ='M', 'Male','Female') as gender
from employees;

select e.emp_no, e.first_name, max(s.salary)-min(s.salary) as sal_diff,
case
	when max(s.salary)-min(s.salary) >=30000 then 'Salary raised by more than 30000'
    when max(s.salary)-min(s.salary) >=20000 between 20000 and 30000 then 'Salary raised by more than 20000 and less than 30000'
    else 'salary raise by less than 20000'
end as salary_increase    
from 
employees e 
join salaries s on e.emp_no = s.emp_no
group by emp_no;

#Q: Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, 
# and last name of all employees with a number higher than 109990. Create a fourth column in the query, indicating 
# whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. 

select e.emp_no, e.first_name, e.last_name,
if(dm.emp_no is null, 'Employee','Manager') as job_role
from employees e 
left join
dept_manager dm on e.emp_no = dm.emp_no
where e.emp_no>109990;

#Q: Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
# Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another 
# one saying whether this salary raise was higher than $30,000 or NOT.

select e.emp_no, e.first_name, e.last_name,
max(s.salary)-min(s.salary) as Sal_diff,
case
	when max(s.salary)-min(s.salary) <30000 then 'Salary raised by less than 30,000'
    when max(s.salary)-min(s.salary) >= 30000 then 'Salary raised by more than 30,000'
end as Raise_by
from employees e 
join
dept_manager dm on e.emp_no = dm.emp_no
join
salaries s on s.emp_no = e.emp_no
group by e.emp_no;

#Q: Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, 
# called “current_employee” saying “Is still employed” if the employee is still working in the company, 
# or “Not an employee anymore” if they aren’t.

select e.emp_no, e.first_name, e.last_name, de.to_date,
case
when max(de.to_date)<sysdate() then 'Not an employee anymore'
else 'Is still employed'
end as current_employee
from employees e
join 
dept_emp de on de.emp_no = e.emp_no
group by e.emp_no
limit 100;

#Q: Create a visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990. 
#year, gender, no of employee

select year(de.from_date) as cal_year, e.gender, count(e.emp_no) as Tot_employees
from employees e
join 
dept_emp de on e.emp_no = de.emp_no
group by cal_year, e.gender	
having cal_year>=1990
order by de.from_date;

#Q: Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.
#gender, emp count, departments, year

Select year(de.from_date) as cal_year , e.gender, d.dept_name, count(e.emp_no)
from employees e
join
dept_manager dm on e.emp_no = dm.emp_no
join
departments d on dm.dept_no = d.dept_no
join 
dept_emp de on de.emp_no = e.emp_no
group by cal_year, e.gender, d.dept_name
having cal_year >= 1990;

#Q: Compare the average salary of female versus male employees in the entire company until year 2002,
# and add a filter allowing you to see that per each department.

select e.gender as Gender, year(s.from_date) as calender_year, d.dept_name, avg(s.salary)
from employees e
join dept_manager dm on e.emp_no = dm.emp_no
join departments d on d.dept_no = dm.dept_no
join salaries s on e.emp_no = s.emp_no
group by e.gender, d.dept_name, calender_year
having calender_year<=2002;

#Q: Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range.
# Let this range be defined by two values the user can insert when calling the procedure.

DROP PROCEDURE IF EXISTS avg_sal;

delimiter $$
Create procedure avg_sal (in p_sal_start integer, in p_sal_end integer)
begin
select e.gender, d.dept_name, avg(s.salary) as average_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_manager dm on e.emp_no = dm.emp_no
join departments d on d.dept_no = dm.dept_no
where s.salary between p_sal_start and p_sal_end
group by e.gender, d.dept_no;
end $$
delimiter ;

call  employees.avg_sal(50000, 90000);


#Q: Find the average salary of the male and female employees in each department. 
 
select e.gender, d.dept_name, avg(s.salary) as Average_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_manager dm on e.emp_no = dm.emp_no
join departments d on d.dept_no = dm.dept_no
group by e.gender, d.dept_name;

#Find the lowest department number encountered in the 'dept_emp' table. Then, find the highest department number. 

select min(dept_no), max(dept_no)
from departments;

select * from dept_emp;

#Q3 

select e.emp_no, min(de.dept_no),
case
when e.emp_no <= 10020 then 110022
else 110039
end as Manager
from employees e
join dept_emp de on e.emp_no = de.emp_no
group by e.emp_no
having e.emp_no <= 10040;

#q3 2nd solution
select e.emp_no,
(
SELECT MIN(dept_no)
FROM dept_emp de
WHERE e.emp_no = de.emp_no
) as department_min,
case
when e.emp_no <= 10020 then 110022
else 110039
end as Manager
from employees e
where e.emp_no<=10040;

#Q4 Retrieve a list of all employees that have been hired in 2000. 

select * from employees 
where hire_date like '%2000%';

SELECT * FROM employees
WHERE YEAR(hire_date) = 2000;

#Q5 Retrieve a list of all employees from the ‘titles’ table who are engineers. 

delimiter $$
create procedure engineers()
begin
select * from titles
where title like '%engineer%';
end $$
delimiter ;

call employees.engineers();

 select * from titles
 where title like '%engineer%';
 
 select * from titles
 where title like '%senior engineer%';
 
#Q6 Create a procedure that asks you to insert an employee number and that will obtain an output containing
# the same number, as well as the number and name of the last department the employee has worked in.
# Finally, call the procedure for employee number 10010. 
DROP procedure IF EXISTS emp_detail;

delimiter $$
create procedure emp_detail(in p_emp_no integer)
begin
select p_emp_no, d.dept_no, d.dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
where e.emp_no = p_emp_no and 
de.from_date = 
(
select max(from_date)
from dept_emp 
where emp_no = p_emp_no
)
;
end $$
delimiter ;

call employees.emp_detail(10010);

#Q7 How many contracts have been registered in the ‘salaries’ table with duration of more than one year and
# of value higher than or equal to $100,000? 

select *, datediff(to_date,from_date)
from salaries
where salary >= 10000;

select count(*)
from salaries
where datediff(to_date, from_date) >= 365
and salary >= 100000;

# Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set the
# hire date to equal the current date. Format the output appropriately (YY-mm-dd).
# Extra challenge: You can try to declare a new variable called 'today' which stores today's data, and then use it in your trigger!
delimiter $$
Create trigger check_date
before insert on employees
for each row
begin
DECLARE today date;
SELECT date_format(sysdate(), '%Y-%m-%d') INTO today;
if new.hire_date > sysdate() then
set hire_date = sysdate();
end if;
end $$
delimiter ;

#Q9: Define a function that retrieves the largest contract salary value of an employee. Apply it to employee number 11356.
# In addition, what is the lowest contract salary value of the same employee? You may want to create a new
# function that to obtain the result. 

delimiter $$
create function max_sal(p_emp_no integer) returns integer
deterministic no sql reads sql data
begin
declare v_max_sal integer;
select max(salary) into v_max_sal
from salaries
where emp_no = p_emp_no;
return v_max_sal;
end $$ 
delimiter ;

select employees.max_sal(11356);

delimiter $$
create function min_sal(p_emp_no integer) returns integer
deterministic no sql reads sql data
begin
declare v_min_sal integer;
select min(salary) into v_min_sal
from salaries
where emp_no = p_emp_no;
return v_min_sal;
end $$ 
delimiter ;

select employees.min_sal(11356);


#Q: Based on the previous exercise, you can now try to create a third function that also accepts a second
# parameter. Let this parameter be a character sequence. Evaluate if its value is 'min' or 'max' and based on
# that retrieve either the lowest or the highest salary, respectively (using the same logic and code structure
# from Exercise 9). If the inserted value is any string value different from ‘min’ or ‘max’, let the function
# return the difference between the highest and the lowest salary of that employee. 

delimiter $$
create function name_func(p_emp_no integer, p_x varchar(255)) returns integer
deterministic no sql reads sql data
begin
declare v_sal integer;

Select
case
	when p_x = 'max' then max(salary)
    when p_x = 'min' then min(salary)
    else max(salary)-min(salary)
end as sal_info into v_sal
from employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
    WHERE
    e.emp_no = p_emp_no;
return v_sal;
end $$
delimiter ;

select employees.name_func(11356, 'min');
select employees.name_func(11356, 'max');
select employees.name_func(11356, 'maxxx');

