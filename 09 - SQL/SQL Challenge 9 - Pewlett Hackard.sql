-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "titles" (
    "title_id" VARCHAR(50)   NOT NULL,
    "title" VARCHAR(200)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(50)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(200)   NOT NULL,
    "last_name" VARCHAR(200)   NOT NULL,
    "sex" VARCHAR(10)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(50)   NOT NULL,
    "dept_name" VARCHAR(250)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_manager_id" serial   NOT NULL,
    "dept_no" VARCHAR(50)   NOT NULL,
	"emp_no" INT   NOT NULL,    
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_manager_id"
     )
);

CREATE TABLE "dept_emp" (
    "dept_emp_id" serial   NOT NULL,
    "emp_no" INT   NOT NULL,
	"dept_no" VARCHAR(50)   NOT NULL,	
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "dept_emp_id"
     )
);

CREATE TABLE "salaries" (
    "salary_id" serial   NOT NULL,
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "salary_id"
     )
);

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

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Question 1 --
Select
	e.emp_no,
	e.last_name,
	e.first_name,
	e.sex,
	s.salary
From
	employees e
	join salaries s on s.emp_no = e.emp_no;
	
-- Question 2 -- 
Select
	emp_no,
	first_name,
	last_name,
	hire_date
From
	employees
Where
	extract(year from hire_date) = 1986
Order By
	last_name asc;

-- Question 3 -- 
Select
	d.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name,
	t.title
From
	employees e
	join dept_emp x on x.emp_no = e.emp_no
	join departments d on d.dept_no = x.dept_no
	join titles t on t.title_id = e.emp_title_id
Where
	title_id = 'm001';

-- Question 4 --
Select
	d.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
From
	employees e
	join dept_emp x on x.emp_no = e.emp_no
	join departments d on d.dept_no = x.dept_no
Order by
	last_name asc:

-- Question 5 --
Select
	last_name,
	first_name
	sex
From
	employees
Where
	first_name = 'Hercules'
	and last_name like 'B%';
	
-- Question 6 --
Select
	e.emp_no,
	e.last_name,
	e.first_name,
	x.dept_no
From
	employees e
	join dept_emp x on x.emp_no = e.emp_no
Where
	dept_no = 'd007'
Order by
	last_name asc;

-- Question 7 -- 
Select
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
From
	employees e
	join dept_emp x on x.emp_no = e.emp_no
	join departments d on d.dept_no = x.dept_no
Where
	dept_name = 'Sales'
	or dept_name = 'Development'
Order by
	last_name asc;
	
-- Question 8 --
Select
	last_name,
	count(last_name) as num_last
From
	employees
Group by
	last_name
Order by 
	num_last desc;