## Project Overview
In this project, I will design, build, and populate a database for the Human Resources (HR) Department at the imaginary Tech ABC Corp, a video game company. This project will start with a request from the HR Manager. From there, I will need to design a database using the foundational principals of data architecture that is best suited to the department's needs. I will go through the steps of database architecture, creating database proposals, database entity relationship diagrams (ERD), and finally creating the database itself.

## Business Scenario
Business requirement
Tech ABC Corp saw explosive growth with a sudden appearance onto the gaming scene with its new AI-powered video game console. As a result, they have gone from a small 10 person operation to 200 employees and 5 locations in under a year. HR is having trouble keeping up with the growth since they are still maintaining employee information in a spreadsheet. While that worked for ten employees, it has become increasingly cumbersome to manage as the company expands.

As such, the HR department has tasked you, as the new data architect, to design and build a database capable of managing their employee information.

## Dataset
The HR dataset is an Excel workbook consisting of 206 records, with eleven columns. The data is in human-readable format and has not been normalized at all. The data lists the names of employees at Tech ABC Corp, as well as information such as job title, department, manager's name, hire date, start date, end date, work location, and salary.

## Solution
### Step 1 : Data Architecture Foundations
Refer [Tech ABC Corp - HR Database.pdf](https://github.com/HockChong/Human-Resources-Database-Design/blob/main/Tech%20ABC%20Corp%20-%20HR%20Database.pdf)
### Step 2 : Relation Database Design
- Conceptual ERD
- <img width="371" alt="image" src="https://github.com/HockChong/Human-Resources-Database-Design/assets/64703507/b046d9a2-7161-4ad6-af1a-f468386994e7">

- Logical ERD
- <img width="389" alt="image" src="https://github.com/HockChong/Human-Resources-Database-Design/assets/64703507/69df1281-fbb2-4f26-bfc0-b1811a7ed50a">

- Physical ERD
- <img width="566" alt="image" src="https://github.com/HockChong/Human-Resources-Database-Design/assets/64703507/fc4ea8e2-971d-40c1-b166-309fd5488547">

### Step 3 : Create a Physical Database
Refer [DDL.sql](https://github.com/HockChong/Human-Resources-Database-Design/blob/main/DDL.sql)
### Step 4 : Above & Beyond(Optional)
Refer [CRUD.sql](https://github.com/HockChong/Human-Resources-Database-Design/blob/main/CRUD.sql)
