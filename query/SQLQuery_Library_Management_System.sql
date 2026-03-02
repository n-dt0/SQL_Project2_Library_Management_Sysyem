---SQL Project2 -Library_Management_System
--## 1. Create database
Create Database SQL_Project2_Library

Use SQL_Project2_Library

--## 2. create tables/Import tables in to database from CSV files to SSMS
---create table dbo.branch---importing csv flat file---

---create table dbo.employees---importing csv flat file---

/*create table dbo.employees---importing csv flat file---
-need to add foreign key constarint for dbo.employees table as we have imported only with primary key*/

Alter TABLE  [dbo].[employees]
ADD CONSTRAINT FK_employees_branch_id FOREIGN KEY (branch_id) REFERENCES branch(branch_id);

---here i observe column emp_name has wrong data type so i changed it with below query---
Alter Table [dbo].[employees]
Alter Column [emp_name] VARCHAR(80) not null;

---create table dbo.members---importing csv flat file---

SELECT * FROM [dbo].[branch]
SELECT * FROM [dbo].[employees]
SELECT * FROM [dbo].[members]
SELECT * FROM [dbo].[books]
SELECT * FROM [dbo].[issued_status]
SELECT * FROM [dbo].[return_status]
---create table dbo.books---importing csv flat file---

---create table dbo.issued_status---importing csv flat file--


-- Project TASK


-- ### 3. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO dbo.books([isbn],[book_title], [category],[rental_price],[status],[author], [publisher])
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM [dbo].[books]


-- Task 2: Update an Existing Member's Address to '125 Main St', member_id = 'C101'.
UPDATE [dbo].[members]
SET [member_address] = '125 Main St'
Where [member_id] = 'C101';
SELECT * FROM [dbo].[members]

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

Delete FROM [dbo].[issued_status]
WHERE [issued_id] = 'IS121';
SELECT * FROM [dbo].[issued_status]

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with issued_emp_id = 'E101'.

SELECT * FROM [dbo].[issued_status]
WHERE [issued_emp_id] = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

Select m.[member_name], count(issmid.[issued_id]) as no_of_books_issued
FROM [dbo].[issued_status] as issmid
Inner join [dbo].[members] as m
ON issmid.issued_member_id = m.member_id
Group by m.member_id, m.member_name
Having count(issmid.issued_id) > 1;


-- ### 4.Create another table with select into statement

-- Task 6: Create Summary Tables**:  generate new tables based on query results 
-- each book and total book_issued_cnt

SELECT b.isbn, b.[book_title], count(issmid.[issued_id]) as book_isued_id
INTO book_issued_count
FROM [dbo].[books] as b
LEFT Join [dbo].[issued_status] as issmid
ON b.isbn = issmid.issued_book_isbn
group by b.isbn, b.[book_title];

Select * from [dbo].[book_issued_count]


-- ### 5. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:"Children"
Select * from dbo.books

Select * FROm dbo.books
Where category = 'Children';

Select * FROm dbo.books
Where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:'classic':table books

Select book_title, sum([rental_price])as sum_of_rental_income
From dbo.books
Where category = 'Classic'
Group by book_title
Order by book_title;

-- Task 9. **List Members Who Registered in the Last 180 Days**:

Select m.[member_id], m.[member_name],m.[member_address] , m.[reg_date] from [dbo].[members] as m
Where m.[reg_date]>=DATEADD(day, -180, m.[reg_date] );


-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:
---we do not have manager's name -- add new column & add 'Sam Joseph' with manager id 'E109'. 'Sandy Cook' with manager id'E110'
Select * from [dbo].[branch]

Alter table[dbo].[branch]
Add manager_name varchar(80);

Update [dbo].[branch]
Set manager_name = 'Sam Joseph'
Where [manager_id] = 'E109';

Update [dbo].[branch]
Set manager_name = 'Sandy Cook'
Where [manager_id] = 'E110';


Select e.[emp_id], e.[emp_name], b.[branch_id] , b.[manager_id], b.[manager_name]
FROM [dbo].[employees] as e
Inner join [dbo].[branch] as b
ON e.[branch_id] = b.branch_id

-- Task 11. Create a Table of Books with Rental Price Above a 7.

Select * from [dbo].[books]
Select * from [dbo].[books]
Where [rental_price] > 7;


-- Task 12: Retrieve the List of Books Not Yet Returned---mean the books which is issued but not returned
Select distinct issts.[issued_book_name]
FROM [dbo].[issued_status] as issts
Left JOin [dbo].[return_status] as rts
ON issts.issued_id = rts.issued_id
Where rts.return_id is null;

    
/*
###  6.Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
--Display the member's name, book title, issue date, and days overdue.*/
USE [SQL_Project2_Library]
Select DATEPART(day, [return_date]) as returnday
from [dbo].[return_status]

Select datepart(day, getdate()) -datepart(day,return_date) as returnday
from [dbo].[return_status]

Select ists.issued_member_id, m.[member_name], bo.[book_title], ists.issued_date,
	DateAdd(day, 30, ists.issued_date) as due_date, 
	Datediff(day, DateAdd(day, 30, ists.issued_date), GETDATE()) as days_over_due
FROM [dbo].[issued_status] as ists
Inner join [dbo].[members] as m
ON ists.issued_member_id = m.member_id
Inner join [dbo].[books] as bo
ON bo.isbn = ists.issued_book_isbn
Inner join [dbo].[return_status] as rts
ON rts.issued_id = ists.issued_id;

    -- this query doesnt give results when it is not null & >30



--Task 14: Update Book Status on Return
--Write a query to update the status of books in the books table to "available" "yes"
--when they are returned (based on entries in the return_status table).

Select * From [dbo].[books]
select * from [dbo].[return_status]

---if the book is returned then to update status as available --- how to know if the book is returned 
--its from returned table
--boooks are issued but not returned 
--join ---books table to issued status table & issued table status table to returned status 
--then update those books which is issued and returned


	Select bk.[isbn], bk.[book_title], bk.[status], 
		isst.[issued_id], rts.[return_id]
	FROM [dbo].[books] as bk
	Inner join [dbo].[issued_status] as isst
	ON bk.isbn = isst.issued_book_isbn
	Inner join [dbo].[return_status] as rts
	ON isst.[issued_id]= rts.[issued_id]
	Where rts.return_id is not null AND 
			bk.[status] = 'yes'


--Task 15: Branch Performance Report
--Create a query that generates a performance report for each branch, 
--showing the number of books issued, the number of books returned, and 
--the total revenue generated from book rentals.
--- order by each branch, cont books issued, count books returned, sum of book rental. 

Select br.[branch_id] , br.manager_id , e.[emp_id],
	   count(isst.[issued_id]) as count_of_bookes_issues_id,
	   count(rts. [return_id])as returned_book_id,
	   sum(bk.[rental_price]) as total_revenue_generated
FROM issued_status as isst
Inner Join [dbo].[employees] as e
ON e.emp_id = isst.issued_emp_id
Inner join [dbo].[branch] as br
ON br.[branch_id] = e.branch_id
Inner join [dbo].[return_status] as rts
ON rts.issued_id = isst.issued_id
Inner Join [dbo].[books] as bk
ON bk.isbn = isst.issued_book_isbn
Group by br.[branch_id] , br.manager_id, e.[emp_id];










