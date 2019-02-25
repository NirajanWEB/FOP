/*-------- Stored Procedures ----------*/
USE AdventureWorks2012
CREATE PROCEDURE sp_GetCustTerritory AS 
SELECT TOP 10 CustomerID, 
Customer.TerritoryID, 
Sales.SalesTerritory.Name FROM Sales.Customer 
JOIN 
Sales.SalesTerritory 
ON 
Sales.Customer.TerritoryID = Sales.SalesTerritory.TerritoryID

EXEC sp_GetCustTerritory

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