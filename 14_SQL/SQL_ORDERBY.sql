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

INSERT INTO dbo.table_5(Employee_role, Summary) 
VALUES ('Research', 'This a very long non-unicode string') 

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

INSERT INTO XML_Store VALUES (100,9833276605,
'<Info> <Call>Local</Call> <Time>45 minutes </Time> <Charges> 200</Charges> </Info>')

SELECT CallDetails FROM XML_Store
0
/*-------- Variables of datatype XML --------*/
DECLARE @xmlvar xml
SELECT @xmlvar='<Employee name="Joan" />'

INSERT INTO XML_Store VALUES (101,9833276606,@xmlvar)
SELECT CallDetails FROM XML_Store
