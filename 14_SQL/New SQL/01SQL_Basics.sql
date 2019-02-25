/* ----------- Creating a Database -------------*/
CREATE DATABASE CUST_DB

/* ----------- using Database ------------------*/
USE CUST_DB

/*------------ Modifying Database --------------*/
ALTER DATABASE CUST_DB MODIFY NAME = STORE_DB

/* ----------- Deleting a Database -------------*/
DROP DATABASE STORE_DB

/* ----------- Creating a Table ----------------*/
CREATE TABLE Customer_1
(
Cust_ID int,
Cust_name varchar(30)
)

/* ----------- Selecting a Table ---------------*/
SELECT * FROM Customer_1

/* ----------- Modifying Tables ----------------*/

/* Following code snippet demonstrates altering the Cust_ID column: */
USE CUST_DB 
ALTER TABLE Customer_1 
ALTER Column Cust_ID bigint;

/* Following code snippet demonstrates adding the Contact_number column: */
USE CUST_DB 
ALTER TABLE Customer_1 
ADD Contact_number bigint;

/* Following code snippet demonstrates dropping the Contact_number column: */
USE CUST_DB 
ALTER TABLE Customer_1 
DROP COLUMN Contact_number

/* ------------ sp_rename ---------------------*/

/* ------------ Renaming a table --------------*/
USE CUST_DB
EXEC sp_rename 'dbo.Customer_1', 'Customer'; 

/* ------------ Renaming a column -------------*/
USE CUST_DB  
EXEC sp_rename 'Customer.Contact_number', 'number', 'COLUMN';


/* ------------ Trucating a Table -------------*/
truncate table Customer

/* ------------ Dropping Tables ---------------*/
USE CUST_DB 
DROP TABLE Customer

/* ------------ Create table Table_2 ----------*/
CREATE TABLE Table_2( 
[Customer_id number] numeric(12, 0) NOT NULL, 
Customer_name varchar(50) NOT NULL,
Contact_name varchar(50),
Contact_number numeric(12,0)
)

/* ------------ INSERT Statement ---------------*/
USE CUST_DB 
INSERT INTO Table_2 VALUES (101, 'Richard Parker', 'Richy',NULL)

/* ------------ UPDATE Statement ---------------*/
USE CUST_DB 
UPDATE Table_2 
SET Contact_number = 5432679 WHERE Contact_name LIKE 'Richy'

/* ------------ DELETE Statement ---------------*/
USE CUST_DB 
DELETE FROM Table_2 
WHERE Contact_number = 5432679 

/* ------------ Column Nullability -------------*/
USE CUST_DB 
CREATE TABLE StoreDetails ( 
StoreID int NOT NULL, 
Name varchar(40) NULL
)

INSERT INTO StoreDetails values (1,NULL)
SELECT * FROM StoreDetails

/* ------------ DEFAULT Definition -------------*/
USE [CUST_DB] 
CREATE TABLE StoreProduct( 
ProductID int NOT NULL, 
Name varchar(40) NOT NULL, 
Price money NOT NULL DEFAULT (100)) 

INSERT INTO dbo.StoreProduct (ProductID, Name) VALUES (111, 'Rivets')
SELECT * FROM StoreProduct

/* ------------ IDENTITY Property -------------*/
CREATE TABLE HRContactPhone ( 
Person_ID int IDENTITY(500,1) NOT NULL, 
MobileNumber bigint NOT NULL )

INSERT INTO HRContactPhone (MobileNumber) VALUES(983452201) 
INSERT INTO HRContactPhone (MobileNumber) VALUES(993026654)
INSERT INTO HRContactPhone (MobileNumber) VALUES(993026655)
SELECT * FROM HRContactPhone

/*------------- Globally Unique Identifiers ----*/
CREATE TABLE EMP_CellularPhone( 
Person_ID uniqueidentifier DEFAULT NEWID() NOT NULL, 
PersonName varchar(60) NOT NULL)

INSERT INTO EMP_CellularPhone(PersonName) VALUES ('William Smith') 
SELECT * FROM EMP_CellularPhone 
select *from HRContactPhone

/*------------- Constraints --------------------*/

/* ------------ UNIQUE -------------------------*/
CREATE TABLE EMP_ContactPhone(
Person_ID int, 
MobileNumber bigint UNIQUE,
ServiceProvider varchar(30),
LandlineNumber bigint UNIQUE)

INSERT INTO EMP_ContactPhone values (111, 983345674, 'Hutch', NULL) 
INSERT INTO EMP_ContactPhone values (112, 983345675, 'Airtel', 123)
select *from EMP_ContactPhone

/*------------ PRIMARY KEY and FORIEGN KEY ---------------------*/
CREATE TABLE EMPContactPhone ( 
EMP_ID int PRIMARY KEY, 
MobileNumber bigint, 
ServiceProvider varchar(30), 
LandlineNumber bigint)

CREATE TABLE EMP_PhoneExpenses ( 
Expense_ID int foreign key references EMPContactPhone(EMP_ID), 
MobileNumber bigint unique, 
Amount bigint) 

-- insert in Pk table
INSERT INTO EMPContactPhone values (101, 983345674,'Hutch', NULL) 
INSERT INTO EMPContactPhone values (102, 989010002,'Airtel', NULL)

select *from EMPContactPhone

INSERT INTO EMPContactPhone values (102, 989010045,'Jio', NULL) --error

-- insert in fk table
INSERT INTO EMP_PhoneExpenses values(101, 983345674, 500) 

SELECT * FROM EMP_PhoneExpenses

INSERT INTO EMP_PhoneExpenses values(103, 983345685, 600)	--error 

/* ----------- CHECK ------------------------- */
CREATE TABLE EMP_PhoneExpense ( 
Expense_ID int, 
MobileNumber bigint, 
Amount bigint CHECK (Amount >10)) 

INSERT INTO dbo.EMP_PhoneExpense values (102, 983345674, 12)
SELECT * FROM dbo.EMP_PhoneExpense



  





