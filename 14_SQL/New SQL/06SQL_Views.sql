/*
SQL Views:
==> In SQL, a view is a virtual table based on the result-set of an SQL statement
==> A view contains rows and columns, just like a real table. The fields in a view are 
fields from one or more real tables in the database.
*/

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
SELECT TOP 100 percent COALESCE(p.Title, ' ') AS Title ,
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
 
 
/* ------------ Insert into views (solve error) ---------------- */
USE CUST_DB
CREATE TABLE Employee_Personal_Details ( 
EmpID1 int NOT NULL, 
FirstName varchar(30) NOT NULL, 
LastName varchar(30) NOT NULL, 
Address varchar(30) 
) 

CREATE TABLE Employee_Salary_Details ( 
EmpID2 int NOT NULL, 
Designation varchar(30), 
Salary int NOT NULL 
)

CREATE VIEW vwEmployee_Detailss AS 
SELECT e1.EmpID1, 
e1.FirstName, 
e1.LastName,
e2.EmpID2, 
e2.Designation, 
e2.Salary 
FROM Employee_Personal_Details e1 
JOIN 
Employee_Salary_Details e2 
ON 
e1.EmpID1 = e2.EmpID2

create trigger employee on vwEmployee_Detailss
instead of insert
	as
	begin
		insert into Employee_Personal_Details (EmpID1, FirstName, LastName)
		select EmpID1,FirstName,Lastname
		from inserted
		insert into Employee_Salary_Details (EmpID2, Designation, Salary)
		select EmpID2, Designation, Salary
		from inserted
	end
 
INSERT INTO vwEmployee_Details VALUES (2,'Jack','Wilson',2,'Software Developer',16000)

select *from vwEmployee_Details

/*------------------- UPDATE with VIEWS --------------------*/
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
Alter table  Product_Details add Description varchar(max)
select *from Product_Details
update Product_Details SET Description = 'Internal' where Description is NULL

CREATE VIEW vwProduct_Detail AS 
SELECT ProductName, 
Description, 
Rate 
FROM Product_Details

UPDATE vwProduct_Detail
SET Description .WRITE('Ex',0,2) 
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

DELETE FROM vwProduct_Details WHERE Rate= 3000
select *from vwProduct_Details

/*--------- Altering VIEWS ------------*/
USE AdventureWorks2012
ALTER VIEW vwProductInfo AS 
SELECT ProductID, ProductNumber, Name, SafetyStockLevel, ReOrderPoint 
FROM Production.Product; 
Go

/*---------- Dropping Views -----------*/
DROP VIEW vwProductInfo

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