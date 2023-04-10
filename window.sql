-- WINDOW FUNCTIONS
-- refer to documentation section 12.21.2 Window Function Concepts and Syntax

-- perform aggreate operations on groups of rows, returning the result into each row as a new column, 
-- instead of collapsing the table by group

CREATE DATABASE window_fx;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

SELECT 
    *
FROM
    employees;

SELECT 
    department, ROUND(AVG(salary), 2) AS AVG_salary
FROM
    employees
GROUP BY department;

-- OVER() constructs the window, one per record when parentheses are empty
SELECT 
	department, 
    AVG(salary) OVER() 
FROM employees;  

-- returns the overall average in a new column, retaining all rows from original table
SELECT 
	emp_no, 
	department, 
    salary, 
    AVG(salary) OVER() AS avg_salary 
FROM employees;  

SELECT 
	emp_no,
    department, 
    salary, 
    MIN(salary) OVER(), 
    MAX(salary) OVER() 
FROM employees;

-- error, missing group by to perform aggregate fx
SELECT 
    emp_no, department, salary, MIN(salary), MAX(salary)
FROM
    employees;  

-- PARTITION BY clause used inside the OVER() will perform the aggregate fx across the specified group
SELECT 
	emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) as dept_avg 
FROM employees;

SELECT 
	emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) as dept_avg,
    AVG(salary) OVER() as company_avg
FROM employees;

-- number of employees per department
SELECT 
	emp_no, 
    department, 
    salary, 
    COUNT(*) OVER(PARTITION BY department) AS dept_count,
    COUNT(*) OVER() AS company_count
FROM employees;

-- payroll per dept
SELECT 
	emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
    SUM(salary) OVER() AS company_payroll
FROM employees;

-- ORDER BY used in the OVER() performs the operation over the next row
SELECT 
	emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_payroll,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_payroll
FROM employees;

-- fxs used only within a WINDOW: 
-- RANK(), returns the rank of the current row within its partition, when rows have the same value they will have the same rank
SELECT
	emp_no, 
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees;

SELECT
	emp_no, 
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_rank, -- used here ORDER BY is within the partition
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees
ORDER BY department;  -- used here, ORDER BY applies to the whole table

-- ROW_NUMBER(), labels each row within the partition in sequence
SELECT
	emp_no, 
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as dept_row_num,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_rank, -- used here ORDER BY is within the partition
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees
ORDER BY department; 

-- DENSE_RANK(), returns the rank of the current row within the partition (without gaps) and then continues with next consecutive number
SELECT
	emp_no, 
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as dept_row_num,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_rank, -- used here ORDER BY is within the partition
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank
FROM employees ORDER BY overall_rank; 

SELECT
	emp_no, 
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as dept_row_num,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_rank, -- used here ORDER BY is within the partition
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

-- NTILE(n) divides a partition into n# buckets
SELECT 
	emp_no, 
    department,
    salary,
	NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
    NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees ORDER BY dept_salary_quartile AND department;

-- FIRST_VALUE(expr) returns the value of the expr from the first row of the window frame
SELECT 
	emp_no, 
    department,
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS highest_paid_overall
FROM employees  ORDER BY department AND salary;

-- LEAD() and LAG() looking forward or backward, performs a calc from one row to the next
SELECT 
	emp_no, 
    department,
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC)
FROM employees;

SELECT 
	emp_no, 
    department,
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff
FROM employees;

-- using a number in the LAG(arg) looks backward the number of rows specified and then performs calc
SELECT 
	emp_no, 
    department,
    salary,
    salary - LAG(salary,2) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diff
FROM employees;