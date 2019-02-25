/*
SQL Joins:
==> Different Types of SQL JOINs:
(INNER) JOIN		: Returns records that have matching values in both tables
LEFT (OUTER) JOIN	: Return all records from the left table, and the matched records from the right table
RIGHT (OUTER) JOIN	: Return all records from the right table, and the matched records from the left table
FULL (OUTER) JOIN	: Return all records when there is a match in either left or right table
*/

/*------- Joins ------------------------*/
SELECT A.FirstName, A.LastName, B.JobTitle 
FROM Person.Person A 
JOIN 
HumanResources.Employee B 
ON 
A.BusinessEntityID = B.BusinessEntityID; 

/*------- Inner Join -------------------*/
SELECT A.FirstName, A.LastName, B.JobTitle 
FROM Person.Person A 
INNER JOIN 
HumanResources.Employee B 
ON 
A.BusinessEntityID = B.BusinessEntityID; 

select *from Person.Person
select *from HumanResources.Employee

/*-------- Left Outer Join -------------*/
SELECT A.CustomerID, B.DueDate, B.ShipDate 
FROM Sales.Customer A 
LEFT OUTER JOIN 
Sales.SalesOrderHeader B 
ON 
A.CustomerID = B.CustomerID AND YEAR(B.DueDate)<2012;

/*-------- Right Outer Join -------------*/
SELECT S.SalesOrderID ,P.Name 
FROM Sales.SalesOrderDetail S 
RIGHT OUTER JOIN 
Production.Product P 
ON 
P.ProductID = S.ProductID

/*--------- Self Join -------------------*/
/* A self JOIN is a regular join, but the table is joined with itself */
SELECT  A.StartDate AS 'BusinessHistory', 
B.StartDate AS 'DepartmentHistory' 
FROM HumanResources.EmployeeDepartmentHistory AS A 
INNER JOIN 
HumanResources.EmployeeDepartmentHistory AS B 
ON 
A.BusinessEntityID = B.DepartmentID

select *from HumanResources.EmployeeDepartmentHistory
