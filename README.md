# SQL_Project2_Library_Management_System

## Project Title: Library Management System
### Level: Intermediate

### Objective
This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

1. Set up the Library Management System Database. Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. CRUD Operations: Perform Create, Read, Update, and Delete operations on the data.
3. Advanced SQL Queries: Develop complex queries to analyze and retrieve specific data. 
    
### Steps
1. Database Creation: Create a database.
2. Import tables from csv files to SSMS.
3. CRUD Operations.
    - Create: Inserted sample records into the books table.
    - Read: Retrieved and displayed data from various tables.
    - Update: Updated records in the employees table.
    - Delete: Removed records from the members table as needed.
4. Create another table with select into statement.
5. Data Analysis & Findings with SQL queries.
6. Advanced SQL Operations.

#### Tasks

| Step | Task | Action | Details / Objective |
|---|---|---|---|
| 3 | 1 | Create a new Book Record | ISBN: `978-1-60129-456-2`; Title: *To Kill a Mockingbird*; Category: Classic; Rental Price: 6.00; Available: `yes`; Author: Harper Lee; Publisher: J.B. Lippincott & Co. |
| 3 | 2 | Update Member Address | Set `address = '125 Main St'` for `member_id = 'C101'`. |
| 3 | 3 | Delete Record | Delete from `issued_status` where `issued_id = 'IS121'`. |
| 3 | 4 | Retrieve Books issued by Employee | Select all books issued by `issued_emp_id = 'E101'`. |
| 3 | 5 | List members with multiple issues | Use `GROUP BY` to find members who have issued more than one book (HAVING `COUNT(*) > 1`). |
| 4 | 6 | Create Summary Tables | Generate new tables based on query results each book and total book_issued_cnt |
| 5 | 7 | Retrieve Books | Retrieve All Books in a Specific Category:"Children" |
| 5 | 8 | Compute Total Rental Income | Find Total Rental Income by Category:'classic':table books |
| 5 | 9 | List Registered Members | List Members Who Registered in the Last 180 Days |
| 5 | 10 | List Employees | List Employees with Their Branch Manager's name and their branch details Who do not have manager's name. add new column & add 'Sam Joseph' with manager id 'E109'. 'Sandy Cook' with manager id 'E110'. |
| 5 | 11 | Rental Price | Create a Table of Books with Rental Price Above a 7. |
| 5 | 12 | Books Not Yet Returned | Retrieve the list of books that are issued but not yet returned (issued but no matching return record). |
| 6 | 13 | Identify Members with Overdue Books | Find members with overdue books (assume 30-day return period). Display member name, book title, issue date, and days overdue. |
| 6 | 14 | Update Book Status on Return | Update `books` to set `available = 'yes'` when a matching `return_status` record exists for the issued book. |
| 6 | 15 | Branch Performance Report | Generate per-branch report showing count of books issued, count returned, and total rental revenue; order by branch. |
 
### Conclusion
This is  designed to manage a library system including handling, issuing, returning books, over due days,rental price,rental income to the libarary, managing staff, and reporting and understanding branch performance. 

