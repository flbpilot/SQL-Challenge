--1. list all employees and display info:  
	-- employee number, last name, first name, sex, and salary.

select a.emp_no, a.last_name, a.first_name, a.sex, b.salary 
from employees a
join salaries b
	on (a.emp_no = b.emp_no)
;

