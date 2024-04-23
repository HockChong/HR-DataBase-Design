--CREATE TABLE 
CREATE TABLE IF NOT EXISTS Occupation (
job_id SERIAL PRIMARY KEY,
job_title VARCHAR(100));

CREATE TABLE IF NOT EXISTS Salary(
salary_id SERIAL PRIMARY KEY,
salary INT);

CREATE TABLE IF NOT EXISTS Department (
department_id SERIAL PRIMARY KEY,
department VARCHAR(50));

CREATE TABLE IF NOT EXISTS Education_level(
edu_id SERIAL PRIMARY KEY,
education VARCHAR(50));

CREATE TABLE IF NOT EXISTS Geography(
loc_id SERIAL PRIMARY KEY,
location VARCHAR(50),
address VARCHAR(100),
city VARCHAR(50),
state VARCHAR(2));

CREATE TABLE IF NOT EXISTS Employee_hist(
emp_id VARCHAR(8),
start_dt date,
hire_dt date,
end_dt date,
emp_name VARCHAR(50),
email VARCHAR(100),
job_id INT REFERENCES Occupation(job_id),
department_id INT REFERENCES Department(department_id),
loc_id INT REFERENCES Geography (loc_id),
edu_id INT REFERENCES Education_level(edu_id),
salary_id INT REFERENCES Salary(salary_id),
manager VARCHAR(50),
PRIMARY KEY (start_dt, emp_id));

--INSERT DATA INTO TABLE FROM STAGING TABLE 
INSERT INTO Occupation (job_title)
SELECT DISTINCT job_title FROM proj_stg;

INSERT INTO Department (department)
SELECT DISTINCT department_nm FROM proj_stg;

INSERT INTO Geography (location, address, city, state)
SELECT location, address, city, state FROM proj_stg
GROUP BY location, address, city, state;

INSERT INTO Education_level (education)
SELECT DISTINCT education_lvl FROM proj_stg;

INSERT INTO Salary (salary)
SELECT salary FROM proj_stg;

INSERT INTO Employee_hist (emp_id, start_dt, job_id, department_id, 
            hire_dt, end_dt, email, emp_name, loc_id, edu_id, salary_id, manager)
SELECT p.Emp_ID, p.start_dt, o.job_id, d.department_id, hire_dt, 
       p.end_dt, p.email, p.Emp_NM, g.loc_id, l.edu_id, s.salary_id, p.manager
FROM proj_stg AS p
JOIN Occupation AS o
ON p.job_title= o.job_title
JOIN Department AS d
ON p.department_nm = d.department
JOIN Salary AS s
ON p.salary = s.salary
JOIN Education_level as l
ON p.education_lvl = l.education
JOIN Geography as g
ON p.location = g.location AND p.address = g.address AND p.city = g.city AND p.state = g.state;