--Challenge 1 Create a view that returns all employee attributes; results should resemble initial Excel file

CREATE VIEW hr_view AS
SELECT e.emp_id, e.emp_name, e.email, e.hire_dt, e.manager, e.start_dt, o.job_title, s.salary, d.department, 
       e.end_dt, g.location, g.address, g.city, g.state, el.education
FROM Employee_hist as e
JOIN Occupation as o ON o.job_id = e.job_id
JOIN Salary as s ON s.salary_id = e.salary_id
JOIN Department as d ON d.department_id = e.department_id 
JOIN Geography as g ON g.loc_id = e.loc_id
JOIN Education_level as el ON el.edu_id = e.edu_id;

'''
Challenge 2
Implement user security on the restricted salary attribute.

Creating a separate table for salary makes applying security rules for that information possible. 
However, just creating the table is only step one. Create a user name `NonMgr` and `REVOKE` that 
user’s rights from viewing the salary table
'''
CREATE USER NonMgr WITH PASSWORD 'your_password';
REVOKE ALL ON Salary FROM NonMgr;


--Question 1: Return a list of employees with Job Titles and Department Names

SELECT e.emp_name, o.job_title, d.department
FROM Employee_hist as e
JOIN Department as d ON d.department_id= e.department_id
JOIN Occupation as o ON o.job_id = e.job_id
ORDER BY d.department, e.emp_name, o.job_title;


--Question 2: Insert Web Programmer as a new job title

INSERT INTO Occupation (job_title)
VALUES ('Web Programmer');

--Question 3: Correct the job title from web programmer to web developer
UPDATE Occupation
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

--Question 4: Delete the job title Web Developer from the database
DELETE FROM Occupation
WHERE job_title = 'Web Developer';

--Question 5:  How many employees are in each department?

SELECT COUNT(e.emp_name) as no_of_employee, d.department
FROM Employee_hist as e
JOIN Department as d on d.department_id = e.department_id
GROUP BY d.department
ORDER BY no_of_employee DESC;

--Question 6:  Write a query that returns current and past jobs (include employee name, job title, 
--department, manager name, start and end date for position) for employee Toni Lembeck.

SELECT e.emp_name, o.job_title, d.department, e.manager, e.start_dt, e.end_dt
FROM Employee_hist as e
JOIN Department as d on d.department_id = e.department_id
JOIN Occupation as o on o.job_id = e.job_id
WHERE e.emp_id IN (SELECT emp_id
                   FROM employee_hist 
                   GROUP BY emp_id
                   HAVING COUNT(DISTINCT start_dt) >1)
ORDER BY e.emp_name ASC, e.end_dt DESC;

