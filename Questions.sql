--Challenge 1 Create a view that returns all employee attributes; results should resemble initial Excel file

CREATE VIEW employee_view AS
SELECT e.emp_id, p.emp_name, e.email, e.hire_dt, o.job_title, s.salary, d.department,
       e.manager, e.start_dt, e.end_dt, e.location, e.address, e.city, e.state, e.education
FROM Employee as p
JOIN Employee_hist as e ON p.emp_id = e.emp_id
JOIN Department as d on d.department_id= e.department_id
JOIN Occupation as o on o.job_id = e.job_id
JOIN Salary as s on s.salary_id = s.salary_id;


--Challenge 2 Create a stored procedure with parameters that return current and past jobs 
--(include employee name, job title, department, manager name, start and end date for the position)
-- when given an employee name.


'''
Implement user security on the restricted salary attribute.

Creating a separate table for salary makes applying security rules for that information possible. 
However, just creating the table is only step one. Create a user name `NonMgr` and `REVOKE` that 
user’s rights from viewing the salary table
'''
CREATE USER NonMgr WITH PASSWORD 'your_password';
REVOKE SELECT ON salary FROM NonMgr;


--Question 1: Return a list of employees with Job Titles and Department Names

SELECT p.emp_name, o.job_title, d.department
FROM Employee as p
JOIN Employee_hist as e ON p.emp_id = e.emp_id
JOIN Department as d on d.department_id= e.department_id
JOIN Occupation as o on o.job_id = e.job_id
ORDER BY d.department, p.emp_name, o.job_title;


--Question 2: Insert Web Programmer as a new job title

INSERT INTO Occupation (job_title)
VALUES ('Web Programmer');

--Question 3: Correct the job title from web programmer to web developer

SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

--Question 4: Delete the job title Web Developer from the database


DELETE FROM Occupation
WHERE job_title = 'Web Developer';

--Question 5:  How many employees are in each department?

SELECT COUNT(p.emp_name) as no_of_employee, d.department
FROM Employee as p
JOIN Employee_hist as e ON p.emp_id = e.emp_id
JOIN Department as d on d.department_id= e.department_id
GROUP BY d.department
ORDER BY no_of_employee DESC;

--Question 6:  Write a query that returns current and past jobs (include employee name, job title, 
--department, manager name, start and end date for position) for employee Toni Lembeck.

SELECT p.emp_name, o.job_title, d.department, e.manager, e.start_dt, e.end_dt
FROM Employee as p
JOIN Employee_hist as e ON p.emp_id = e.emp_id
JOIN Department as d on d.department_id= e.department_id
JOIN Occupation as o on o.job_id = e.job_id
WHERE e.emp_id IN (SELECT emp_id
                   FROM employee_hist 
                   GROUP BY emp_id
                   HAVING COUNT(DISTINCT start_dt) >1)
ORDER BY p.emp_name ASC, e.end_dt DESC;

