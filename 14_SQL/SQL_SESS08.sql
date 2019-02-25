/*--------- SELECT statement -----------*/

/*--------- SELECT Without FROM ----------*/
SELECT LEFT('International',5)

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

/*-------- GROUP BY --------------------------*/
USE AdventureWorks2012 
SELECT WorkOrderID,SUM(ActualResourceHrs) 
FROM Production.WorkOrderRouting 
GROUP BY WorkOrderID

/*-------- Common Table Expression (CTE) in SELECT and INSERT statement ------*/
USE CUST_DB 
CREATE TABLE NewEmployees (
EmployeeID smallint,FirstName char(10), 
LastName char(10), 
Department varchar(50), 
HiredDate datetime, Salary money ); 



This IsSS a House
thith ithth a houthe
rahulzha93@gmail.com



 
INSERT INTO NewEmployees VALUES(11,'Kevin','Blaine', 'Research', '2012-07-31', 54000); 
WITH EmployeeTemp (EmployeeID,FirstName,LastName,Department, HiredDate,Salary) 
AS 
( 
SELECT * FROM NewEmployees 
) 
SELECT * FROM EmployeeTemp

/*------- OUTPUT clause in INSERT and UPDATE statements ------*/
CREATE TABLE dbo.table_3 ( 
id INT, 
employee VARCHAR(32) 
) 
go 

INSERT INTO dbo.table_3 VALUES 
(1, 'Matt'),
(2, 'Joseph'),
(3, 'Renny'),
(4, 'Daisy'); 
GO 

DECLARE @updatedTable TABLE ( 
id INT, 
olddata_employee VARCHAR(32), 
newdata_employee VARCHAR(32) 
); 

UPDATE dbo.table_3 
Set 
employee= UPPER(employee)
 
OUTPUT 
inserted.id, 
deleted.employee, 
inserted.employee 
INTO @updatedTable 
SELECT * FROM @updatedTable
 
/*-------- .WRITE clause ---------*/
USE CUST_DB; 
GO 
CREATE TABLE dbo.table_5 ( 
Employee_role VARCHAR(max), 
Summary VARCHAR(max) 
)

INSERT INTO dbo.table_5(Employee_role, Summary) VALUES ('Research', 'This a very long non-unicode string') 

SELECT *FROM dbo.table_5 

UPDATE dbo.table_5 
SET 
Summary .WRITE('n incredibly', 6,5) 
WHERE 
Employee_role LIKE 'Research' 

SELECT *FROM dbo.table_5

/*--------- ORDER BY Clause ----------*/
USE AdventureWorks2012 
SELECT * FROM Sales.SalesTerritory ORDER BY SalesLastYear ASC
SELECT * FROM Sales.SalesTerritory ORDER BY SalesLastYear DESC
SELECT * FROM Sales.SalesTerritory ORDER BY SalesLastYear

/*--------- Working With XML ---------*/
USE CUST_DB 
CREATE TABLE XML_Store(
Bill_ID int PRIMARY KEY, 
MobileNumber bigint UNIQUE, 
CallDetails xml) 

INSERT INTO XML_Store VALUES (100,9833276605,'<Info> <Call>Local</Call> <Time>45 minutes </Time> <Charges> 200</Charges> </Info>')

SELECT CallDetails FROM XML_Store
0
/*-------- Variables of datatype XML --------*/
DECLARE @xmlvar xml
SELECT @xmlvar='<Employee name="Joan" />'INSERT INTO XML_Store VALUES (101,9833276606,@xmlvar)SELECT CallDetails FROM XML_Store/*-------- Typed XML ---------*//*-------- XML instance which has a schema associated with it -------*/USE CUST_DB
CREATE XML SCHEMA COLLECTION CricketSchemaCollection
AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" >
<xsd:element name="MatchDetails">
<xsd:complexType>
<xsd:complexContent>
<xsd:restriction base="xsd:anyType">
<xsd:sequence>
<xsd:element name="Team" minOccurs="0" maxOccurs="unbounded">
<xsd:complexType>
<xsd:complexContent>
<xsd:restriction base="xsd:anyType">
<xsd:sequence />
<xsd:attribute name="country" type="xsd:string" />
<xsd:attribute name="score" type="xsd:string" /></xsd:restriction>
</xsd:complexContent>
</xsd:complexType>
</xsd:element>
</xsd:sequence>
</xsd:restriction>
</xsd:complexContent>
</xsd:complexType>
</xsd:element>
</xsd:schema>'
GOCREATE TABLE CricketTeam ( TeamID int identity not null, TeamInfo
xml(CricketSchemaCollection) )
INSERT INTO CricketTeam (TeamInfo) VALUES ('<MatchDetails><Team
country="Australia" score="355"></Team><Team country="Zimbabwe"
score="200"></Team><Team country="England"
score="475"></Team></MatchDetails>')
SELECT * FROM CricketTeam

/*------- Typed XML using Variable ------*/
DECLARE @team xml(CricketSchemaCollection)
SET @team = '<MatchDetails><Team
country="Australia"></Team></MatchDetails>'
SELECT @team
GO

/*------- XQuery(used to access XML data)-----------*/

/*------- exist() ----------*/
SELECT TeamID FROM CricketTeam WHERE
TeamInfo.exist('(/MatchDetails/Team)') = 1

/*------- query() ----------*/SELECT TeamInfo.query('/MatchDetails/Team') AS Info FROM CricketTeam
/*------- value() ----------*/
SELECT TeamInfo.value('(/MatchDetails/Team/@score)[1]', 'varchar(20)') AS
Score FROM CricketTeam where TeamID=1