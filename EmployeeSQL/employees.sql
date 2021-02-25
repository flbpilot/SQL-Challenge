
--1. List the following details of each employee: employee number, last name, first name, sex, and salary.

select a.emp_no, a.last_name, a.first_name, a.sex, b.salary 
from employees a
join salaries b
	on (a.emp_no = b.emp_no)
;

--2. List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date
from employees
where date_part('year', hire_date) = '1986'
;

--3. List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.

select a.dept_no, b.dept_name, a.emp_no, c.last_name, c.first_name 
from dept_manager a
join departments b
	on (a.dept_no = b.dept_no)
join employees c
	on (a.emp_no = c.emp_no)
;

--4. List the department of each employee with the following information: employee number, last name, 
--first name, and department name.