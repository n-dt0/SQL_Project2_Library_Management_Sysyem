---SQL Project2 -Library_Management_System
--## 1. CREATE DATABASE
CREATE DATABASE SQL_Project2_Library

USE SQL_Project2_Library

--## 2. CREATE TABLES/IMPORT TABLES INTO DATABASE FROM CSV FILES TO SSMS
---CREATE TABLE dbo.branch---IMPORTING CSV FLAT FILE---

---CREATE TABLE dbo.employees---IMPORTING CSV FLAT FILE---

/*CREATE TABLE dbo.employees---importing csv flat file---
-NEED TO ADD FOREIGN KEY CONSTRAINT FOR dbo.employees table as we have imported only with PRIMARY KEY*/

ALTER TABLE  [dbo].[employees]
ADD CONSTRAINT FK_employees_branch_id FOREIGN KEY (branch_id) REFERENCES branch(branch_id);

---here i observe column emp_name has wrong data type so i changed it with below query---
ALTER TABLE [dbo].[employees]
ALTER COLUMN [emp_name] VARCHAR(80) NOT NULL;

---CREATE TABLE dbo.members---IMPORTING CSV FLAT FILE---

SELECT * FROM [dbo].[branch]
SELECT * FROM [dbo].[employees]
SELECT * FROM [dbo].[members]
SELECT * FROM [dbo].[books]
SELECT * FROM [dbo].[issued_status]
SELECT * FROM [dbo].[return_status]
---CREATE TABLE dbo.books---IMPORTING CSV FLAT FILE---

---CREATE TABLE dbo.issued_status---IMPORTING CSV FLAT FILE--


-- Project TASK


-- ### 3. CRUD Operations


-- Task 1. CREATE A NEW BOOK RECORD
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO dbo.books([isbn],[book_title], [category],[rental_price],[status],[author], [publisher])
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM [dbo].[books]


-- Task 2: UPDATE AN EXISTING MEMBER'S ADDRESS TO '125 Main St', member_id = 'C101'.
UPDATE [dbo].[members]
SET [member_address] = '125 Main St'
WHERE [member_id] = 'C101';
SELECT * FROM [dbo].[members]

-- Task 3: DELETE A RECORD FROM THE ISSUED STATUS TABLE
-- OBJECTIVE: DELETE the record with issued_id = 'IS121' FROM the issued_status TABLE.

DELETE FROM [dbo].[issued_status]
WHERE [issued_id] = 'IS121';
SELECT * FROM [dbo].[issued_status]

-- Task 4: RETRIEVE ALL BOOKS ISSUED BY A SPECIFIC EMPLOYEE
-- OBJECTIVE: SELECT ALL BOOKS ISSUED BY THE EMPLOYEE WITH issued_emp_id = 'E101'.

SELECT * FROM [dbo].[issued_status]
WHERE [issued_emp_id] = 'E101';

-- Task 5: LIST MEMBERS WHO HAVE ISSUED MORE THAN ONE BOOK
-- OBJECTIVE: USE GROUP BY TO FIND members who HAVE ISSUED more THAN one book.

SELECT m.[member_name], COUNT(issmid.[issued_id]) AS no_of_books_issued
FROM [dbo].[issued_status] AS issmid
INNER JOIN [dbo].[members] AS m
ON issmid.issued_member_id = m.member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(issmid.issued_id) > 1;


-- ### 4.CREATE ANOTHER TABLE WITH SELECT INTO STATEMENT

-- Task 6: CREATE SUMMARY TABLES**: generate new tables based on query results 
-- each book AND total book_issued_cnt

SELECT b.isbn, b.[book_title], COUNT(issmid.[issued_id]) AS book_isued_id
INTO book_issued_count
FROM [dbo].[books] AS b
LEFT JOIN [dbo].[issued_status] AS issmid
ON b.isbn = issmid.issued_book_isbn
GROUP BY b.isbn, b.[book_title];

SELECT * FROM [dbo].[book_issued_count]


-- ### 5. Data Analysis & Findings

-- Task 7. **RETRIEVE ALL BOOKS IN A SPECIFIC CATEGORY:"Children"
SELECT * FROM dbo.books

SELECT * FROM dbo.books
WHERE category = 'Children';

SELECT * FROM dbo.books
WHERE category = 'Classic';

-- Task 8: FIND TOTAL RENTAL INCOME BY CATEGORY:'classic':TABLE books

SELECT book_title, SUM([rental_price])AS sum_of_rental_income
FROM dbo.books
WHERE category = 'Classic'
GROUP BY book_title
ORDER BY book_title;

-- Task 9. **LIST MEMBERS WHO REGISTERED IN THE LAST 180 DAYS**:

SELECT m.[member_id], m.[member_name],m.[member_address] , m.[reg_date] FROM [dbo].[members] AS m
WHERE m.[reg_date]>=DATEADD(day, -180, m.[reg_date] );


-- Task 10: LIST EMPLOYEES WITH THEIR BRANCH MANAGER'S NAME AND their branch details**:
---WE DO NOT HAVE manager's name -- ADD NEW COLUMN & ADD 'Sam Joseph' WITH manager id 'E109'. 'Sandy Cook' WITH manager id'E110'
SELECT * FROM [dbo].[branch]

ALTER TABLE[dbo].[branch]
ADD manager_name VARCHAR(80);

UPDATE [dbo].[branch]
SET manager_name = 'Sam Joseph'
WHERE [manager_id] = 'E109';

UPDATE [dbo].[branch]
SET manager_name = 'Sandy Cook'
WHERE [manager_id] = 'E110';


SELECT e.[emp_id], e.[emp_name], b.[branch_id] , b.[manager_id], b.[manager_name]
FROM [dbo].[employees] AS e
INNER JOIN [dbo].[branch] AS b
ON e.[branch_id] = b.branch_id

-- Task 11. CREATE A TABLE OF BOOKS WITH RENTAL PRICE ABOVE A 7.

SELECT * FROM [dbo].[books]
SELECT * FROM [dbo].[books]
WHERE [rental_price] > 7;


-- Task 12: RETRIEVE THE LIST OF BOOKS NOT YET RETURNED---MEAN THE BOOKS WHICH IS ISSUED BUT NOT RETURNED
SELECT DISTINCT issts.[issued_book_name]
FROM [dbo].[issued_status] AS issts
LEFT JOIN [dbo].[return_status] AS rts
ON issts.issued_id = rts.issued_id
WHERE rts.return_id IS NULL;

    
/*
###  6.Advanced SQL Operations

Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
--Display the member's name, book title, issue date, and days overdue.*/
USE [SQL_Project2_Library]
SELECT DATEPART(day, [return_date]) AS returnday
FROM [dbo].[return_status]

SELECT DATEPART(day, GETDATE()) -DATEPART(day,return_date) AS returnday
FROM [dbo].[return_status]

SELECT ists.issued_member_id, m.[member_name], bo.[book_title], ists.issued_date,
	DATEADD(day, 30, ists.issued_date) AS due_date, 
	DATEDIFF(day, DATEADD(day, 30, ists.issued_date), GETDATE()) AS days_over_due
FROM [dbo].[issued_status] AS ists
INNER JOIN [dbo].[members] AS m
ON ists.issued_member_id = m.member_id
INNER JOIN [dbo].[books] AS bo
ON bo.isbn = ists.issued_book_isbn
INNER JOIN [dbo].[return_status] AS rts
ON rts.issued_id = ists.issued_id;

    -- this query doesnt give results when it is not null & >30



--Task 14: UPDATE BOOK STATUS ON RETURN
--WRITE A QUERY TO UPDATE THE STATUS OF BOOKS IN THE books TABLE TO "available" "yes"
--WHEN THEY ARE RETURNED (BASED ON ENTRIES IN THE return_status TABLE).

SELECT * FROM [dbo].[books]
SELECT * FROM [dbo].[return_status]

---IF THE BOOK IS RETURNED THEN TO UPDATE STATUS AS AVAILABLE --- HOW TO KNOW IF THE BOOK IS RETURNED 
--ITS FROM returned TABLE
--BOOKS ARE ISSUED BUT NOT RETURNED 
--JOIN ---books TABLE TO issued status TABLE & issued TABLE status TABLE TO returned status 
--THEN UPDATE THOSE BOOKS WHICH IS ISSUED AND RETURNED


	SELECT bk.[isbn], bk.[book_title], bk.[status], 
		isst.[issued_id], rts.[return_id]
	FROM [dbo].[books] AS bk
	INNER JOIN [dbo].[issued_status] AS isst
	ON bk.isbn = isst.issued_book_isbn
	INNER JOIN [dbo].[return_status] AS rts
	ON isst.[issued_id]= rts.[issued_id]
	WHERE rts.return_id IS NOT NULL AND 
			bk.[status] = 'yes'


--Task 15: BRANCH PERFORMANCE REPORT
--CREATE A QUERY THAT GENERATES A PERFORMANCE REPORT FOR EACH BRANCH, 
--SHOWING THE NUMBER OF BOOKS ISSUED, THE NUMBER OF BOOKS RETURNED, AND 
--THE TOTAL REVENUE GENERATED FROM BOOK RENTALS.
--- ORDER BY EACH BRANCH, COUNT books issued, COUNT books returned, SUM OF book rental. 

SELECT br.[branch_id] , br.manager_id , e.[emp_id],
	   COUNT(isst.[issued_id]) AS count_of_bookes_issues_id,
	   COUNT(rts. [return_id])AS returned_book_id,
	   SUM(bk.[rental_price]) AS total_revenue_generated
FROM issued_status AS isst
INNER JOIN [dbo].[employees] AS e
ON e.emp_id = isst.issued_emp_id
INNER JOIN [dbo].[branch] AS br
ON br.[branch_id] = e.branch_id
INNER JOIN [dbo].[return_status] AS rts
ON rts.issued_id = isst.issued_id
INNER JOIN [dbo].[books] AS bk
ON bk.isbn = isst.issued_book_isbn
GROUP BY br.[branch_id] , br.manager_id, e.[emp_id];










