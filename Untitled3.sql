use employees;

select * from employees;

SELECT 
    dept_no
FROM
    departments;
    
select * from departments;

select * from employees
where first_name="elvis";

select * from employees
where gender='F' and first_name='kellie'; 

select * from employees
where first_name='Denis';


select * from employees
where first_name='elvis';


select * from employees
where first_name='Denis' or first_name='elvis';


select * from employees
where (first_name='kellie' or first_name='aruna') and gender='f';

select * from employees
where first_name not in ('denis','elvis','john');

select * from employees
where first_name like('mark%');


select * from employees
where hire_date like('2000%');

select * from employees
where emp_no like('1000_');


select * from employees
where hire_date like('%2000%');


select * from employees
where first_name like('%jack%');

select * from employees
where first_name not like('%jack%');

select * from salaries
Where salary NOT BETWEEN 66000 AND 70000;

select * from salaries
Where salary BETWEEN 66000 AND 70000;

select * from salaries;

Select dept_name from departments
where dept_no is not null;

Select * from employees
Where gender='F'  and hire_date >= '2000-01-01';

Select * from salaries
where salary >=150000;

select distinct hire_date from employees;

SELECT 
    COUNT(Salary)
FROM
    salaries
WHERE
    salary > 100000;
    
Select Count(*) from employees;

select * from employees
order by hire_date desc;

Select salary, count(emp_no) as emps_with_same_salary from salaries
where salary > 80000
group by salary 
order by salary;

Select salary, count(salary) from salaries;

Select emp_no, count(emp_no) from salaries
group by (emp_no);

select emp_no, avg(salary) from salaries
group by emp_no
having avg(salary)>120000;

SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;


SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

select first_name, count(first_name) from employees
where hire_date > '1999-01-01'
group by first_name
having count(first_name)< 200;  

select emp_no, count(emp_no) from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(emp_no)>1;

select * from dept_emp
limit 50;

Select * from titles
limit 10;

INSERT INTO titles
(
emp_no,
title,
from_date
)
VALUES
(103,
'Senior Engineer',
'1997-10-01'
);

insert into dept_emp
(
emp_no,
dept_no,
from_date,
to_date
)
values
(
999903,
'doo5',
'1997-10-01',
'9999-01-01'
);

Insert into departments
values
(
'd010',
'business analyst'
);

select * from departments
order by dept_no desc;




update departments
set
dept_name='Data Analasys'
Where
dept_no='d010';

select * from departments
order by dept_no desc;

ROLLBACK;

commit;

update departments
set
dept_name='BA'
where 
dept_no='d010';

select * from departments
order by dept_no desc;

Rollback;

select * from departments
order by dept_no desc;

update departments
set dept_name="Business Analytics"
where
dept_name="BA";


select * from departments
order by dept_no desc;


update departments
set dept_name="Data Analysis"
where
dept_name="BA";

select * from departments
order by dept_no desc;

Commit;

select * from titles
order by emp_no desc;

Delete from employees
where emp_no= 499999;

Rollback;

select * from employees
order by emp_no desc;

Rollback;

select * from employees
order by emp_no desc;

commit;

Delete from employees
where emp_no= 499998;

select * from employees
order by emp_no desc;

commit;

rollback;

delete from departments
where dept_no='d010';

select * from departments;

rollback;

select count(distinct dept_no) from dept_emp;

Select ROUND(AVG(salary),2) from salaries where from_date>'1997-01-01'; 

select * from departments 
limit 10;


Select dept_no, dept_name, coalesce(dept_no,dept_name) as dept_info
from departments;

Select ifnull(dept_no,"NA") as dept_no, ifnull(dept_name,"not present")as dept_name, coalesce(dept_no,dept_name) as dept_info
from departments;

Create table departments_dup
(
dept_no char(4) null,
dept_name varchar(40) null
);

Insert into departments_dup
Select * from departments;

select *from departments_dup;

insert into departments_dup
(
dept_name
)
values
("Public Relations"
);

select *from departments_dup;

Delete from departments_dup
where dept_no='d002';

SET SQL_SAFE_UPDATES = 0;

insert into departments_dup
(dept_no,dept_name)
values('d087','abc'),('d023','efg');

select * from departments_dup;

Insert into departments_dup
(dept_no)
values
('d010'),('d011');

select * from departments
where dept_no > 'd004';

select * from departments_dup
order by dept_no;

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

WHERE

    dept_no = 'd001';
    
INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

DELETE FROM departments_dup

WHERE

    dept_no = 'd002'; 
    
select * from dept_manager_dup
order by dept_no;

select e.emp_no, e.first_name, e.last_name, e.hire_date, m.dept_no
from employees e
join dept_manager_dup m on e.emp_no = m.emp_no;     

Select e.emp_no,e.first_name, m.dept_no, e.last_name, m.from_date
from employees e
left join dept_manager m on e.emp_no = m.emp_no
where e.last_name='Markovitch'
order by m.dept_no desc;

select e.emp_no, e.first_name, e.last_name, d.dept_no ,e.hire_date
from employees e
join dept_manager d on e.emp_no = d.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch';

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY emp_no;

Select e.*, d.*
From employees e 
cross join
departments d
where emp_no < 10010
order by e.emp_no, d.dept_no; 

Select e.gender, avg(s.salary) as average_salary
from employees e
join
salaries s on e.emp_no= s.emp_no
group by gender;

Select e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
From employees e 
join 
titles t on e.emp_no = t.emp_no
join
dept_manager m on m.emp_no = e.emp_no
join
departments d on m.dept_no = d.dept_no
Where t.title="Manager"
order by e.emp_no;   

Select e.first_name, e.last_name, e.hire_date, t.title, t.from_date, d.dept_name
From employees e 
join 
titles t on e.emp_no = t.emp_no
join
dept_emp de on de.emp_no = e.emp_no
join
departments d on de.dept_no = d.dept_no
Where t.title="Manager"   
order by e.emp_no;


select e.gender, count(e.emp_no)
from employees e 
join 
titles t on e.emp_no = t.emp_no
where title ="manager" 
group by gender;

SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
JOIN
dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;



SELECT
    *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' 
        UNION 
        SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;


Select e.first_name, e.last_name
from employees e
where e.emp_no in (select d.emp_no
from dept_manager as d
where d.from_date between '1990-01-01' and '1995-01-01'
);

Select e.first_name, e.last_name
from employees e
join 
dept_manager d on e.emp_no = d.emp_no
where d.from_date between '1990-01-01' and '1995-01-01';


select * from dept_manager d
where d.emp_no in (select e.emp_no
from employees e
where e.hire_date between '1990-01-01' and '1995-01-01' );

Select * from employees e
WHERE Exists(Select * 
from titles t
where e.emp_no = t.emp_no and title = "Assistant engineer"
);

Select A.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110022) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no<=10020
		group by e.emp_no
		order by e.emp_no) as A
Union
Select B.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110039) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no>10020
		group by e.emp_no
		order by e.emp_no
        Limit 20) as B;
        
Drop table if exists emp_manager;

Create table emp_manager
(emp_no int(11) Not Null,
dept_no char(4) Null,
Manager_no int(11) Not null);

Insert INTO emp_manager SELECT
U.*
From(
Select A.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110022) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no<=10020
		group by e.emp_no
		order by e.emp_no) as A
Union
Select B.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110039) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no>10020
		group by e.emp_no
		order by e.emp_no
        Limit 20) as B
Union
Select C.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110039) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no=110022
		group by e.emp_no
		order by e.emp_no) as C    
Union
Select D.* 
From (Select e.emp_no as employee_ID, min(de.dept_no) as deptartment_code,
		(Select emp_no
		from dept_manager
		where emp_no=110022) as manager_id
		from employees e
		join
		dept_emp as de on e.emp_no=de.emp_no
		where de.emp_no=110039
		group by e.emp_no
		order by e.emp_no) as D
        ) as U;   
        
        Select * from emp_manager;
        
        Select * from dept_manager order by emp_no;
        
        Select * from emp_manager em right join dept_manager dm on em.emp_no=dm.emp_no order by dm.emp_no;
        
Create or replace view average_manager_salary as 
Select Round(avg(salary),2)
from salaries s
join 
dept_manager dm
where s.emp_no = dm.emp_no;

SELECT * FROM employees.average_manager_salary;

Delimiter $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$
DELIMITER ;

Call employees.select_employees();

Call select_employees();

DELIMiTER $$
Create procedure average_salary_emp()
BEGIN
SELECT AVG(salary)
from salaries;
END$$
DELIMITER ;

call average_salary_emp();

Drop procedure select_employees;

Delimiter $$
create procedure emp_salary(IN p_emp_no integer)
begin
select e.first_name, s.salary, avg(s.salary)
from employees e
join 
salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;


delimiter $$
create procedure emp_info(in p_fname varchar(255),in p_lname varchar(255), out p_emp_no integer)
begin
Select e.emp_no
into p_emp_no
from employees e
where e.first_name = p_fname and e.last_name = p_lname;
end$$
delimiter ;

delimiter $$
create procedure find_em_no(in p_fname varchar(255), in p_name varchar(255), out p_emp_no integer)
begin
select e.emp_no
from employees e
where e.first_name = p_fname and e.last_name = p_name;
end$$
delimeter ;

call find_em_no

Select * from employees
limit 5;

Set @v_emp_no=0;
call emp_info('aruna','journel',@v_emp_no);
select @v_emp_no;




DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
	DECLARE v_max_from_date date;
    DECLARE v_salary decimal(10,2);
SELECT
    MAX(from_date)
INTO v_max_from_date 
FROM employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
SELECT
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERe
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
                RETURN v_salary;
END$$
DELIMITER ;
SELECT EMP_INFO('Aruna', 'Journel');

set @v_fname='aruna';
set @v_lname='journel';
select emp_no, first_name, emp_info(@v_fname,@v_lname)
from employees 
where
first_name=@v_fname;

select first_name, emp_no
from employees
where first_name = 'Aruna';

create index i_first_name on employees(first_name);

alter table employees
drop index i_first_name;

Select * from salaries
where salary > 89000;
 
create index i_salary on salaries(salary);


Select emp_no,first_name,
case gender
when 'm' then 'Male'
else 'Female'
end as gender 
from employees;


Select e.emp_no, e.first_name,
if (gender ='M', 'Male', 'Female') as gender
from employees e;


Select e.emp_no, e.first_name, 
case
when d.dept_no is not null then 'Manager'
else 'female'
end as manager
from employees e
left join 
dept_manager d on e.emp_no = d.emp_no
where e.emp_no > 109990;


Select dm.emp_no, e.first_name, e.last_name, MAX(s.salary) - min(s.salary) as Salary_difference,
case
when max(s.salary) - min(s.salary) > 30000 then 'salary greater than $30,000'
else 'salary less than $30,000'
end as status_of_salary
from employees e
join 
dept_manager dm on e.emp_no = dm.emp_no
join 
salaries s on dm.emp_no = s.emp_no
group by s.emp_no;


Select e.emp_no, e.first_name, e.last_name,
if (d.to_date < sysdate(), "Not an employee anymore", "is still working") as current_employees
from employees e
join
dept_emp d on e.emp_no = d.emp_no
Limit 100;

use employees;

select d.dept_name as Department, e.gender as gender, avg(s.salary) as Avg_salary
from
employees e 
join
salaries s on e.emp_no = s.emp_no
join
dept_emp de on e.emp_no = de.emp_no
join
departments d on de.dept_no = d.dept_no
group by e.gender, d.dept_name;

select dept_no as d_no,count(dept_no)
from dept_emp
group by d_no; 



