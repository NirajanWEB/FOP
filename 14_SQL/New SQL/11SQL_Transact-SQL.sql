/*

==> Transact-SQL programming elements enable to perform various operations that cannot be done 
in a single statement
==> Transact-SQL programming also has rules and syntax that control and enable programming 
statements to work together
==> Users can control the flow of programs by using conditional statements such as IF and 
loops such as WHILE
*/

/* Transact-SQL Batch */
BEGIN TRANSACTION
GO
USE AdventureWorks2012;
GO
CREATE TABLE Company
(
Id_Num int IDENTITY(100, 5),
Company_Name varchar(100)
)
GO
INSERT INTO Company (Company_Name)
VALUES ('A Bike Store')
INSERT INTO Company (Company_Name)
VALUES ('Progressive Sports')
INSERT INTO Company (Company_Name)
VALUES ('Modular Cycle Systems')
INSERT INTO Company (Company_Name)
VALUES ('Advanced Bike Components')
INSERT INTO Company (Company_Name)
VALUES ('Metropolitan Sports Supply')
INSERT INTO Company (Company_Name)
VALUES ('Aerobic Exercise Company')
INSERT INTO Company (Company_Name)
VALUES ('Associated Bikes')
INSERT INTO Company (Company_Name)
VALUES ('Exemplary Cycles')
GO
SELECT Id_Num, Company_Name
FROM dbo.Company
ORDER BY Company_Name ASC;
GO
COMMIT;
GO


/* Transact-SQL Variables */
USE AdventureWorks2012;
GO
DECLARE @find varchar(30) = 'Man%';
SELECT p.LastName, p.FirstName, ph.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE LastName LIKE @find;


/* Transact-SQL variable using SET */
DECLARE @myvar varchar(20);
SET @myvar = 'This is a test';


/* Transact-SQL Variable using Select */
USE AdventureWorks2012 ;
GO
DECLARE @var1 varchar(30);
SELECT @var1 = 'Unnamed Company';
SELECT @var1 = Name
FROM Sales.Store
WHERE BusinessEntityID = 10;
SELECT @var1 AS 'Company Name';


/* Program Flow Statements */

/* BEGIN ...END 
==> BEGIN…END statements surround a series of Transact-SQL statements so that a group of 
Transact-SQL statements is executed.
*/
USE AdventureWorks2012;
GO

BEGIN TRANSACTION;
GO
IF @@TRANCOUNT = 0
BEGIN
SELECT FirstName, MiddleName
FROM Person.Person WHERE LastName = 'Andy';
ROLLBACK TRANSACTION;
PRINT 'Rollingback the transaction two times would cause an error.';
END;
ROLLBACK TRANSACTION;
PRINT 'Rolledback the transaction.';
GO

/* IF…ELSE
==> IF…ELSE statement enforces a condition on the execution of a Transact-SQL statement.
==> Transact-SQL statement is followed with the IFkeyword and the condition executes only 
if the condition is satisfied and returns TRUE.
==> ELSE keyword is an optional Transact-SQL statement that executes only when the IF condition 
is not satisfied and returns FALSE.
*/

USE AdventureWorks2012
GO
DECLARE @ListPrice money;
SET @ListPrice= (SELECT MAX(p.ListPrice)
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS s
ON p.ProductSubcategoryID= s.ProductSubcategoryID
WHERE s.[Name] = 'Mountain Bikes');
PRINT @ListPrice
IF @ListPrice<3000
PRINT 'All the products in this category can be purchased for an amount less than 3000'
ELSE
PRINT 'The prices for some products in this category exceed 3000'


/* WHILE
==> WHILE-statements specifies a condition for the repetitive execution of the statement block.
==> Statements are executed repetitively as long as the specified condition is true.
==> The execution of statements in the WHILE loop can be controlled by using the BREAK and CONTINUE keywords.

*/

DECLARE @flag int
SET @flag = 10
WHILE (@flag <=95)
BEGIN
IF @flag%2 =0
PRINT @flag
SET @flag = @flag + 1
CONTINUE;
END
GO



