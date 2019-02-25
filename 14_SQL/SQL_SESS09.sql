/*------- GROUPING DATA ---------*/

/*------- GROUP BY --------------*/
USE AdventureWorks2012
SELECT WorkOrderID, SUM(ActualResourceHrs) AS TotalHoursPerWorkOrder 
FROM Production.WorkOrderRouting GROUP BY WorkOrderID

/*------- GROUP BY with WHERE -------*/
SELECT WorkOrderID, SUM(ActualResourceHrs) AS TotalHoursPerWorkOrder 
FROM Production.WorkOrderRouting WHERE WorkOrderID <50 GROUP BY WorkOrderID 

/*------- GROUP BY with NULL --------*/
SELECT Class, AVG (ListPrice) AS 'AverageListPrice' FROM Production.Product GROUP BY Class

/*------- GROUP BY with ALL --------*/
SELECT [Group],SUM(SalesYTD) AS 'TotalSales' 
FROM Sales.SalesTerritory WHERE [Group] LIKE 'N%' OR [Group] LIKE 'E%' GROUP BY ALL [Group]

/*------- GROUP BY with HAVING --------*/
SELECT [Group],SUM(SalesYTD) AS 'TotalSales' 
FROM Sales.SalesTerritory WHERE [Group] LIKE 'P%' GROUP BY [Group] HAVING SUM(SalesYTD)<6000000

/*------- CUBE -----------------------*/
SELECT Name,CountryRegionCode,SUM(SalesYTD) AS TotalSales 
FROM Sales.SalesTerritory WHERE Name <> 'Australia' AND Name <> 'Canada' 
GROUP BY Name,CountryRegionCode WITH CUBE

/*------- ROLLUP ----------------------*/
SELECT Name ,SUM(SalesYTD) AS TotalSales 
FROM Sales.SalesTerritory WHERE Name <> 'Australia' AND Name<> 'Canada' 
GROUP BY Name WITH ROLLUP

/*------- Aggrigate Functions ----------*/
/*------- AVG, MIN, MAX (numeric)-------*/
SELECT AVG([UnitPrice]) AS AvgUnitPrice, 
MIN([OrderQty])AS MinQty, 
MAX([UnitPriceDiscount]) AS MaxDiscount 
FROM Sales.SalesOrderDetail;

/*------- AVG (Error) ------------------*/
SELECT SalesOrderID, AVG(UnitPrice) AS AvgPrice FROM Sales.SalesOrderDetail; /* remove SalesOrderID */

/*------- MIN, MAX (Date,Time) ---------*/
SELECT MIN(OrderDate) AS Earliest, MAX(OrderDate) AS Latest FROM Sales.SalesOrderHeader



/*------- Spatial Aggrigate ------------*/
/*------- STUnion() --------------------*/
SELECT geometry::Point(251, 1, 4326).STUnion(geometry::Point(252,2,4326));

/*------- STUnion() geometry ------------*/
DECLARE @g geometry;  
DECLARE @h geometry;  
SET @g = geometry::STGeomFromText('POLYGON((0 0, 0 2, 2 2, 2 0, 0 0))', 0);  
SET @h = geometry::STGeomFromText('POLYGON((1 1, 3 1, 3 3, 1 3, 1 1))', 0);  
SELECT @g.STUnion(@h)

/*------- STUnion() geometry -----------*/
DECLARE @g geometry = 'CURVEPOLYGON(CIRCULARSTRING(0 -4, 4 0, 0 4, -4 0, 0 -4))';  
DECLARE @h geometry = 'POLYGON((5 -1, 5 -3, 7 -3, 7 -1, 5 -1))';  
SELECT @g.STUnion(@h)

/*------- New Spatial Aggrigate ---------*/
/*------- Union Aggrigate ---------------*/
use AdventureWorks2012;
SELECT Geography::UnionAggregate(SpatialLocation) 
AS AVGLocation FROM Person.Address WHERE City = 'London'; 

/*------- Envelope Aggrigate ------------*/
SELECT Geography::EnvelopeAggregate(SpatialLocation) 
AS Location FROM Person.Address WHERE City = 'London';

/*------- Collection Aggrigate ----------*/
DECLARE @CollectionDemo TABLE ( 
shape geometry, shapeType nvarchar(50) ) 
INSERT INTO @CollectionDemo(shape,shapeType) 
VALUES('CURVEPOLYGON(CIRCULARSTRING(2 3, 4 1, 6 3, 4 5, 2 3))', 'Circle'), 
('POLYGON((1 1, 4 1, 4 5, 1 5, 1 1))', 'Rectangle'); 
SELECT geometry::CollectionAggregate(shape) FROM @CollectionDemo;

/*------- Convex Hull Aggrigate ---------*/
SELECT Geography::ConvexHullAggregate(SpatialLocation) 
AS Location FROM Person.Address WHERE City = 'London'

/*------- Subqueries --------------------*/
SELECT DueDate, ShipDate FROM Sales.SalesOrderHeader 
WHERE Sales.SalesOrderHeader.OrderDate = (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)

/*------- Working with Multi-valued Queries (IN)------*/
SELECT FirstName, LastName FROM Person.Person 
WHERE Person.Person.BusinessEntityID IN (
SELECT BusinessEntityID FROM HumanResources.Employee 
WHERE JobTitle ='Research and Development Manager');

/*------- EXISTS Keyword ----------------*/
SELECT FirstName, LastName FROM Person.Person AS A 
WHERE EXISTS (SELECT * FROM HumanResources.Employee As B 
WHERE JobTitle ='Research and Development Manager' 
AND A.BusinessEntityID=B.BusinessEntityID);

/*------- Nested Subqueries ------------*/
SELECT LastName, FirstName 
FROM Person.Person 
WHERE BusinessEntityID IN (
SELECT BusinessEntityID 
FROM Sales.SalesPerson 
WHERE TerritoryID IN (
SELECT TerritoryID 
FROM Sales.SalesTerritory 
WHERE Name='Canada') ) 

/*------- Correlated Queries ------------*/
SELECT e.BusinessEntityID 
FROM Person.BusinessEntityContact e 
WHERE e.ContactTypeID IN ( 
SELECT c.ContactTypeID 
FROM Person.ContactType c 
WHERE YEAR(e.ModifiedDate) >=2012 )

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
SELECT P.Name, S.SalesOrderID 
FROM Sales.SalesOrderDetail S 
RIGHT OUTER JOIN 
Production.Product P 
ON 
P.ProductID = S.ProductID

/*--------- Self Join -------------------*/
SELECT  A.StartDate AS 'BusinessHistory', 
B.StartDate AS 'DepartmentHistory' 
FROM HumanResources.EmployeeDepartmentHistory AS A 
INNER JOIN 
HumanResources.EmployeeDepartmentHistory AS B 
ON 
A.BusinessEntityID = B.DepartmentID

select *from HumanResources.EmployeeDepartmentHistory

/*--------- MERGE Statement --------------*/
MERGE INTO Products AS P1 
USING NewProducts AS P2 
ON 
P1.ProductId = P2.ProductId 
WHEN MATCHED THEN 
UPDATE SET 
P1.Name = P2.Name, 
P1.Type = P2.Type, 
P1.PurchaseDate = P2.PurchaseDate 
WHEN NOT MATCHED THEN 
INSERT (ProductId, Name, Type, PurchaseDate) 
VALUES (P2.ProductId, P2.Name, P2.Type, P2.PurchaseDate) 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE 
OUTPUT $action, Inserted.ProductId, Inserted.Name, Inserted.Type, 
Inserted.PurchaseDate, Deleted.ProductId,Deleted.Name, Deleted.Type, 
Deleted.PurchaseDate; 