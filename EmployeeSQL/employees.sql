-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" TEXT   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" TEXT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" TEXT   NOT NULL,
    "last_name" TEXT   NOT NULL,
    "sex" TEXT   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" TEXT   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "dept_manager" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(5)   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(5)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);



ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");


--1. List the following details of each employee: employee number, last name, first name, sex, and salary.

select e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
from employees e
join salaries s
	on (e.emp_no = s.emp_no)
;

--2. List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date
from employees
where date_part('year', hire_date) = '1986'
;

--3. List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.

select d.dept_no, dep.dept_name, d.emp_no, e.last_name, e.first_name 
from dept_manager d
join departments dep
	on (d.dept_no = dep.dept_no)
join employees e
	on (d.emp_no = e.emp_no)
;

--4. List the department of each employee with the following information: employee number, last name, 
--first name, and department name.

select d.emp_no, e.last_name, e.first_name, dep.dept_name  
from dept_emp d
join departments dep
	on (d.dept_no = dep.dept_no)
join employees e
	on (d.emp_no = e.emp_no)
;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select first_name, last_name
from employees
where first_name = 'Hercules'
and last_name like 'B%'	
;

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

select d.emp_no, e.last_name, e.first_name, dep.dept_name
from dept_emp d
join employees e
	on (d.emp_no = e.emp_no)
join departments dep
	on (d.dept_no = dep.dept_no)
where d.dept_no in (
	select dept_no 
	from departments 
	where dept_name = 'Sales'
	)
;

--7. List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.

select d.emp_no, e.last_name, e.first_name, dep.dept_name
from dept_emp d
join employees e
	on (d.emp_no = e.emp_no)
join departments dep
	on (d.dept_no = dep.dept_no)
where d.dept_no in (
	select dept_no 
	from departments 
	where dept_name = 'Sales'
	or dept_name = 'Development'
	)
;

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

SELECT last_name, COUNT(last_name) AS count
FROM employees
GROUP BY 1
ORDER BY count DESC

;