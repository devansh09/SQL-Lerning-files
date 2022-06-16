use employees;

select * from employees
where first_name = "Elvis";

Select * from employees
where gender = 'F' and first_name = 'Kellie';


Select * from employees
where first_name ='aruna' or first_name = 'kellie';


Select * from employees
where first_name in ('aruna','kellie');


Select * from employees
where gender = 'F' and (first_name ='aruna' or first_name = 'kellie');

select * from employees
where first_name not in ('John', 'Mark', 'Jacob');

select * from employees
where first_name like ('Mark%');

select * from employees
where hire_date like ('%2000%');

select * from employees
where emp_no like ('1000_');

select * from employees
where first_name like ('%jack%');


select * from employees
where first_name not like ('%jack%');

SELECT dept_name
FROM departments
WHERE dept_no IS NOT NULL;

select * from employees
where gender = 'F' and hire_date like ('%200%');

select * from employees
where gender = 'F' and hire_date > '2000-01-01';


select * 
from employees e
join salaries s on e.emp_no = s.emp_no
where s.salary >150000;

select distinct hire_date from employees;