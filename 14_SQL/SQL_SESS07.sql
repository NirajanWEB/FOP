/*------- Alias Datatype ---------*/
CREATE TYPE usertype FROM varchar(20) NOT NULL

/*------- Creating Tables --------*/
CREATE TABLE [dbo].[Customer_1]( 
[Customer_id number] [numeric](10, 0) NOT NULL, 
[Customer_name] [varchar](50) NOT NULL
) ON [PRIMARY] 

select *from Customer_1

/*------- Modifying Tables -------*/

/*  Following code snippet demonstrates altering the Customer_id column: */
USE [CUST_DB] 
ALTER TABLE [dbo].[Customer_1] 
ALTER Column [Customer_id number] [numeric](12, 0) NOT NULL;

/*  Following code snippet demonstrates adding the Contact_number column: */
USE [CUST_DB] 
ALTER TABLE [dbo].[Customer_1] 
ADD [Contact_number] [numeric](12, 0) NOT NULL

/* Following code snippet demonstrates dropping the Contact_number column: */
USE [CUST_DB] 
ALTER TABLE [dbo].[Customer_1] 
DROP COLUMN [Contact_number];

/* ------ Dropping Tables --------*/
USE [CUST_DB] 
DROP TABLE [dbo].[Customer_1]
 
/* ------ Create table Table_2-------*/
CREATE TABLE [dbo].[Table_2]( 
[Customer_id number] [numeric](12, 0) NOT NULL, 
[Customer_name] [varchar](50) NOT NULL,
[Contact_name] [varchar](50),
[Contact_number] [numeric](12,0)
) ON [PRIMARY]

/* ------ INSERT Statement --------*/
USE [CUST_DB] 
INSERT INTO [dbo].[Table_2] VALUES (101, 'Richard Parker', 'Richy',NULL)

/* ------ UPDATE Statement --------*/
USE [CUST_DB] 
UPDATE [dbo].[Table_2] 
SET Contact_number = 5432679 WHERE Contact_name LIKE 'Richy'

/* ------- DELETE Statement -------*/
USE [CUST_DB] 
DELETE FROM [dbo].[Table_2] 
WHERE Contact_number = 5432679 

/* -------- Column Nullability ------*/
USE [CUST_DB] 
CREATE TABLE StoreDetails ( 
StoreID int NOT NULL, 
Name varchar(40) NULL
)

INSERT INTO StoreDetails values (1,NULL)
SELECT * FROM StoreDetails

/* -------- DEFAULT Definition --------*/
USE [CUST_DB] 
CREATE TABLE StoreProduct( 
ProductID int NOT NULL, 
Name varchar(40) NOT NULL, 
Price money NOT NULL DEFAULT (100)) 

INSERT INTO dbo.StoreProduct (ProductID, Name) VALUES (111, 'Rivets')
SELECT * FROM StoreProduct

/* ------- IDENTITY Property ---------*/
CREATE TABLE HRContactPhone ( 
Person_ID int IDENTITY(500,1) NOT NULL, 
MobileNumber bigint NOT NULL )

INSERT INTO HRContactPhone (MobileNumber) VALUES(983452201) 
INSERT INTO HRContactPhone (MobileNumber) VALUES(993026654)
INSERT INTO HRContactPhone (MobileNumber) VALUES(993026655)
SELECT * FROM HRContactPhone

/*------- Globally Unique Identifiers ----------*/
CREATE TABLE EMP_CellularPhone( 
Person_ID uniqueidentifier DEFAULT NEWID() NOT NULL, 
PersonName varchar(60) NOT NULL)

INSERT INTO EMP_CellularPhone(PersonName) VALUES ('William Smith') 
SELECT * FROM EMP_CellularPhone 
select *from HRContactPhone

/*------- Constraints --------*/


/*------- PRIMARY KEY -------*/
CREATE TABLE EMPContactPhone ( 
EMP_ID int PRIMARY KEY, 
MobileNumber bigint, 
ServiceProvider varchar(30), 
LandlineNumber bigint)

INSERT INTO dbo.EMPContactPhone values (101, 983345674,'Hutch', NULL) 
INSERT INTO dbo.EMPContactPhone values (102, 989010002,'Airtel', NULL)
select *from EMPContactPhone

/* ------- UNIQUE --------*/
CREATE TABLE EMP_ContactPhone(
Person_ID int PRIMARY KEY, 
MobileNumber bigint UNIQUE,
ServiceProvider varchar(30),
LandlineNumber bigint UNIQUE)

INSERT INTO EMP_ContactPhone values (111, 983345674, 'Hutch', NULL) 
INSERT INTO EMP_ContactPhone values (112, 983345675, 'Airtel', 123)
select *from EMP_ContactPhone

/* -------- FORIEGN KEY --------*/
CREATE TABLE EMP_PhoneExpenses ( 
Expense_ID int PRIMARY KEY, 
MobileNumber bigint FOREIGN KEY REFERENCES EMP_ContactPhone (MobileNumber), 
Amount bigint) 

INSERT INTO dbo.EMP_PhoneExpenses values(111, 983345674, 500) 
SELECT * FROM dbo.EMP_PhoneExpenses

/* -------- CHECK ------------ */
CREATE TABLE EMP_PhoneExpense ( 
Expense_ID int PRIMARY KEY, 
MobileNumber bigint FOREIGN KEY REFERENCES EMP_ContactPhone (MobileNumber), 
Amount bigint CHECK (Amount >10)) 

INSERT INTO dbo.EMP_PhoneExpense values (102, 983345674, 12)
SELECT * FROM dbo.EMP_PhoneExpense

