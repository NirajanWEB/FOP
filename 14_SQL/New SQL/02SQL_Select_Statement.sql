/*--------- SELECT statement -----------*/

/*--------- SELECT Without FROM ----------*/
SELECT LEFT('International',5)
SELECT RIGHT('International',5)

/*--------- Displaying All Columns ---------*/
USE AdventureWorks2012 
SELECT * FROM HumanResources.Employee

/*--------- Displaying Selected Columns ------*/
USE AdventureWorks2012 
SELECT LocationID,CostRate FROM Production.Location

/*------- Using Constants in Result sets ------*/
USE AdventureWorks2012 
SELECT [Name] +':'+ CountryRegionCode +'-->'+ [Group] FROM Sales.SalesTerritory

/*------- Renaming ResultSet Column Names -------*/
SELECT [Name] +':'+ CountryRegionCode +'-->'+ [Group] AS [Renamed Column] FROM Sales.SalesTerritory

/*------- Computing Values in ResultSet --------*/
SELECT ProductID,StandardCost,StandardCost * 0.15 as Discount FROM Production.ProductCostHistory

/*------- Using DISTINCT -----------------------*/
SELECT DISTINCT StandardCost FROM Production.ProductCostHistory 

/*-------- Using TOP and PERCENT ---------------*/
SELECT DISTINCT TOP 10 StandardCost FROM Production.ProductCostHistory
SELECT DISTINCT TOP 10 PERCENT StandardCost FROM Production.ProductCostHistory

/*-------- SELECT with INTO -------------------*/
USE AdventureWorks2012
SELECT ProductModelID,Name FROM Production.ProductModel
SELECT ProductModelID,Name INTO Production.ProductName FROM Production.ProductModel
SELECT ProductModelID,Name FROM Production.ProductName

/*-------- SELECT with WHERE ------------------*/
USE AdventureWorks2012
SELECT *FROM Production.ProductCostHistory WHERE EndDate = '2013-05-29 00:00:00.000'
SELECT *FROM Person.Address WHERE City = 'Bothell'
SELECT *FROM HumanResources.Department WHERE DepartmentID < 10 

/*-------- WILD CARDS ------------------------*/
SELECT *FROM Person.Person WHERE Suffix LIKE 'Jr_'
SELECT *FROM Person.Person WHERE LastName LIKE 'B%'
SELECT *FROM Sales.CurrencyRate WHERE ToCurrencyCode LIKE 'C[AN][DY]'
SELECT *FROM Sales.CurrencyRate WHERE ToCurrencyCode LIKE 'A[^R][^S]'

/*-------- SELECT with Where -----------------*/
SELECT * FROM Sales.Customer  WHERE StoreID > 900 AND CustomerID = 5
SELECT * FROM Sales.Customer  WHERE StoreID > 900 OR CustomerID = 5
SELECT * FROM Sales.Customer  WHERE NOT CustomerID > 5