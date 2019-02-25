/*---------- Creating Views --------------*/
USE AdventureWorks2012;
CREATE VIEW vwProductInfo AS 
SELECT ProductID, ProductNumber, Name, SafetyStockLevel FROM Production.Product; 
GO
SELECT * FROM vwProductInfo
Select *from Production.Product

/*---------- Creating Views Using JOIN Keyword --------------*/
CREATE VIEW vwPersonDetails AS 
SELECT p.Title ,
p.[FirstName] ,
p.[MiddleName] ,
p.[LastName] ,
e.[JobTitle] 
FROM [HumanResources].[Employee] e 
INNER JOIN 
[Person].[Person] p 
ON 
p.[BusinessEntityID] = e.[BusinessEntityID] 
GO
select *from HumanResources.Employee
select *from Person.Person
SELECT * FROM  vwPersonDetails

/*--------- Creating Views Using JOIN ,COALESCE()--------------*/
CREATE VIEW vwPersonDetail AS 
SELECT COALESCE(p.Title, '0') AS Title ,
p.[FirstName] ,
COALESCE(p.MiddleName, '-') AS MiddleName ,
p.[LastName] ,
e.[JobTitle] 
FROM [HumanResources].[Employee] e 
INNER JOIN 
[Person].[Person] p 
ON 
p.[BusinessEntityID] = e.[BusinessEntityID] 
GO

SELECT * FROM  vwPersonDetail

/*--------- Creating Views Using JOIN ,COALESCE(), ORDER BY--------------*/
CREATE VIEW vwSortedPersonDetailss AS 
SELECT TOP 10 COALESCE(p.Title, ' ') AS Title ,
p.[FirstName] ,
COALESCE(p.MiddleName, ' ') AS MiddleName ,
p.[LastName] ,
e.[JobTitle] 
FROM [HumanResources].[Employee] e 
INNER JOIN 
[Person].[Person] p 
ON 
p.[BusinessEntityID] = e.[BusinessEntityID] 
ORDER BY p.FirstName 
GO 
SELECT * FROM vwSortedPersonDetailss

/*---------- INSERT with VIEWS --------------*/
USE CUST_DB
CREATE TABLE Employee_Personal_Details ( 
EmpID int NOT NULL, 
FirstName varchar(30) NOT NULL, 
LastName varchar(30) NOT NULL, 
Address varchar(30) ) 

CREATE TABLE Employee_Salary_Details ( 
EmpID int NOT NULL, 
Designation varchar(30), 
Salary int NOT NULL )

CREATE VIEW vwEmployee_Detailsd AS 
SELECT e1.EmpID, 
e1.FirstName, 
e1.LastName, 
e2.Designation, 
e2.Salary 
FROM Employee_Personal_Details e1 
JOIN 
Employee_Salary_Details e2 
ON 
e1.EmpID = e2.EmpID

INSERT INTO vwEmployee_Details VALUES (2,'Jack','Wilson','Software Developer',16000) /*error*/

CREATE VIEW vwEmpDetails AS 
SELECT FirstName, Address FROM Employee_Personal_Details 
GO

INSERT INTO vwEmpDetails VALUES ('Jack','NYC')/*error*/

/*---------- UPDATE with VIEWS --------------*/
CREATE TABLE Product_Details ( 
ProductID int, 
ProductName varchar(30), 
Rate money) 

INSERT INTO Product_Details values (5,'DVD Writer',2250.00)
INSERT INTO Product_Details values (4,'DVD Writer',1250.00)
INSERT INTO Product_Details values (6,'DVD Writer',1250.00)
INSERT INTO Product_Details values (2,'External Hard Drive',4250.00)
INSERT INTO Product_Details values (3,'External Hard Drive',4250.00)

CREATE VIEW vwProduct_Details AS 
SELECT ProductName, Rate FROM Product_Details

select *from vwProduct_Details

UPDATE vwProduct_Details 
SET 
Rate=3000 WHERE ProductName='DVD Writer'

select *from vwProduct_Details 

/*-------- UPDATE with Views(.write clause)------------*/
Alter table  Product_Details add Description nvarchar(max)
select *from Product_Details
update Product_Details SET Description = 'Internal' where Description is NULL

CREATE VIEW vwProduct_Detail AS 
SELECT ProductName, 
Description, 
Rate 
FROM Product_Details

UPDATE vwProduct_Detail
SET Description .WRITE('IN',0,2) 
WHERE ProductName='External Hard Drive'

select *from vwProduct_Detail

/*--------- DELETE with VIEWS ---------*/
CREATE VIEW vwCustDetail AS 
SELECT ProductID, 
ProductName, 
Rate 
FROM Product_Details

DELETE FROM vwCustDetail WHERE ProductID= 5 
select *from vwCustDetail

/*--------- Altering VIEWS ------------*/
USE AdventureWorks2012
ALTER VIEW vwProductInfo AS 
SELECT ProductID, ProductNumber, Name, SafetyStockLevel, ReOrderPoint 
FROM Production.Product; 
Go

/*---------- Dropping Views -----------*/
DROP VIEW vwProductInfo

/*---------- sp_helptext --------------*/ 
EXEC sp_helptext vwPersonDetails

/*----- Creating Views using Built-In Functions -------*/
USE CUST_DB
CREATE VIEW vwProduct_Detailss AS 
SELECT ProductName, 
AVG(Rate) AS AverageRate 
FROM Product_Details 
GROUP BY ProductName

select *from vwProduct_Detailss

/*----- View with CHECK Option ------------*/
USE AdventureWorks2012
CREATE VIEW vwProductInfo AS 
SELECT ProductID, 
ProductNumber,
Name,
SafetyStockLevel, 
ReOrderPoint 
FROM Production.Product 
WHERE SafetyStockLevel <=1000 WITH CHECK OPTION; 
GO

UPDATE vwProductInfo SET SafetyStockLevel= 2500 WHERE ProductID=321

/*------------- SCHEMABINDING Option ------------*/
CREATE VIEW vwNewProductInfo 
WITH SCHEMABINDING AS 
SELECT ProductID, 
ProductNumber, 
Name, 
SafetyStockLevel FROM Production.Product; 
GO 
ALTER TABLE Production.Product ALTER COLUMN ProductID varchar(7)/*error*/


/*---------  sp_refreshview ------------*/
USE CUST_DB
CREATE TABLE Customers ( 
CustID int, 
CustName varchar(50), 
Address varchar(60) )

CREATE VIEW vwCustomers AS SELECT * FROM Customers

select *from Customers
SELECT * FROM vwCustomers

ALTER TABLE Customers ADD Age int

SELECT * FROM vwCustomers

EXEC sp_refreshview 'vwCustomers'


/*-------- Stored Procedures ----------*/
USE AdventureWorks2012
CREATE PROCEDURE uspGetCustTerritory AS 
SELECT TOP 10 CustomerID, 
Customer.TerritoryID, 
Sales.SalesTerritory.Name FROM Sales.Customer 
JOIN 
Sales.SalesTerritory 
ON 
Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID

EXEC uspGetCustTerritory

/*--------- Stored Procedures using input parameters ---------*/
CREATE PROCEDURE uspGetSales 
@territory varchar(40) 
AS 
SELECT BusinessEntityID, B.SalesYTD, B.SalesLastYear 
FROM Sales.SalesPerson A 
JOIN 
Sales.SalesTerritory B 
ON A.TerritoryID = B.TerritoryID 
WHERE B.Name = @territory

EXEC uspGetSales 'Northwest'

/*--------- Stored Procedures using output parameters ---------*/
CREATE PROCEDURE uspGetTotalSale
@territory varchar(40), 
@sum int OUTPUT AS 
SELECT @sum= SUM(B.SalesYTD) 
FROM Sales.SalesPerson A 
JOIN 
Sales.SalesTerritory B 
ON 
A.TerritoryID = B.TerritoryID 
WHERE B.Name = @territory

DECLARE @sumsales money; 
EXEC uspGetTotalSale 'Northwest', 
@sum = @sumsales OUTPUT; 
PRINT 'The year-to-date sales figure for this territory is ' + convert(varchar(100),@sumsales); 
GO 

/*-------- Altering Stored Procedure -----------*/
ALTER PROCEDURE [dbo].[uspGetTotalSale] 
@territory varchar = 40 AS 
SELECT BusinessEntityID, B.SalesYTD, B.CostYTD, B.SalesLastYear 
FROM Sales.SalesPerson A 
JOIN 
Sales.SalesTerritory B 
ON 
A.TerritoryID = B.TerritoryID 
WHERE B.Name = @territory; 
GO 

/*-------- Dropping Stored Procedure -----------*/
DROP PROCEDURE uspGetTotals

/*-------- Nested Stored Procedure --------------*/
CREATE PROCEDURE NestedProcedure 
AS 
BEGIN 
EXEC uspGetCustTerritory 
END

EXEC NestedProcedure

/*-------- @@NESTLEVEL Function -----------------*/
CREATE PROCEDURE Nest_Procedure 
AS 
SELECT @@NESTLEVEL AS NestLevel; 
EXECUTE ('SELECT @@NESTLEVEL AS [NestLevel With Execute]'); 
EXECUTE sp_executesql N'SELECT @@NESTLEVEL AS [NestLevel With sp_executesql]'; 



EXECUTE Nest_Procedure 

/*--------- Querying System Metadata --------*/
SELECT name, object_id, type, type_desc FROM sys.tables;

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE FROM INFORMATION_SCHEMA.TABLES

SELECT SERVERPROPERTY('EDITION') AS EditionName;

/*------- Categorizing and Querying DMVs -------*/
SELECT session_id, login_time, program_name FROM sys.dm_exec_sessions 
WHERE login_name ='sa' and is_user_process =1