--CREATE TABLE 
CREATE TABLE IF NOT EXISTS Occupation (
job_id SERIAL PRIMARY KEY,
job_title VARCHAR(100));

CREATE TABLE IF NOT EXISTS Department (
department_id SERIAL PRIMARY KEY,
department VARCHAR(50));

CREATE TABLE IF NOT EXISTS Employee (
emp_id VARCHAR(8) NOT NULL PRIMARY KEY,
emp_name VARCHAR(50));

CREATE TABLE IF NOT EXISTS Salary(
salary_id SERIAL PRIMARY KEY,
salary INT);

CREATE TABLE IF NOT EXISTS Employee_hist(
emp_id VARCHAR(8) NOT NULL REFERENCES Employee(emp_id),
job_id INT REFERENCES Occupation(job_id),
department_id INT REFERENCES Department(department_id),
salary_id INT REFERENCES Salary(salary_id),
hire_dt date,
start_dt date,
end_dt date,
manager VARCHAR(50),
location VARCHAR(50),
email VARCHAR(100),
address VARCHAR(100),
city VARCHAR(50),
state VARCHAR(2),
education VARCHAR(50),
PRIMARY KEY (start_dt, emp_id));

--INSERT DATA INTO TABLE FROM STAGING TABLE 
INSERT INTO Occupation (job_title)
SELECT DISTINCT(job_title) FROM proj_stg;

INSERT INTO Department (department)
SELECT DISTINCT(department_nm) FROM proj_stg;

INSERT INTO Employee (emp_id, emp_name)
SELECT DISTINCT Emp_ID, Emp_NM
FROM proj_stg;

INSERT INTO Salary (salary)
SELECT salary FROM proj_stg;

INSERT INTO Employee_hist (emp_id, job_id, department_id, salary_id, 
            hire_dt, start_dt, end_dt, manager, location, address, city, state, education)
SELECT p.Emp_ID, o.job_id, d.department_id, s.salary_id, hire_dt, 
       p.start_dt, p.end_dt, p.manager, p.location, p.address, p.city, p.state, p.education_lvl
FROM proj_stg AS p
JOIN Occupation AS o
ON p.job_title= o.job_title
JOIN Department AS d
ON p.department_nm = d.department
JOIN Salary AS s
ON p.salary = s.salary;