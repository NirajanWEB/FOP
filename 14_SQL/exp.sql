/*------- GROUP BY --------------*/
USE AdventureWorks2012
SELECT WorkOrderID, SUM(ActualResourceHrs) AS TotalHoursPerWorkOrder 
FROM Production.WorkOrderRouting GROUP BY WorkOrderID

/*------- GROUP BY with WHERE -------*/
SELECT WorkOrderID, SUM(ActualResourceHrs) AS TotalHoursPerWorkOrder 
FROM Production.WorkOrderRouting WHERE WorkOrderID <50 GROUP BY WorkOrderID 

/*------- GROUP BY with HAVING --------*/
SELECT [Group],SUM(SalesYTD) AS 'TotalSales' 
FROM Sales.SalesTerritory WHERE [Group] LIKE 'P%' GROUP BY [Group] HAVING SUM(SalesYTD)<6000000

/*------- ROLLUP ----------------------*/
SELECT Name ,SUM(SalesYTD) AS TotalSales 
FROM Sales.SalesTerritory WHERE Name <> 'Australia' AND Name<> 'Canada' 
GROUP BY Name WITH ROLLUP