/*
Error Handling

Try ...Catch
==> Are used to implement exception handling in Transact-SQL
==> Can enclose one or more Transact-SQL statements within a TRY block.
==> Passes control to the CATCH block that may contain one or more statements, 
if an error occurs in the TRY block.
*/

BEGIN TRY
DECLARE @num int;
SELECT @num=217/0;
END TRY
BEGIN CATCH
PRINT 'Error occurred, unable to divide by 0'
END CATCH;


/* Error Information 
System functions are as follows:
•ERROR_NUMBER(): returns the number of error.
•ERROR_SEVERITY(): returns the severity.
•ERROR_STATE(): returns state number of the error.
•ERROR_PROCEDURE(): returns the name of the trigger or stored procedure where the error occurred.
•ERROR_LINE(): returns the line number that caused the error.
•ERROR_MESSAGE(): returns the complete text of the error. 
The text contains the value supplied for the parameters such as object names, length, or times.

*/
USE AdventureWorks2012;
GO
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_SEVERITY() AS ErrorSeverity,
ERROR_LINE() AS ErrorLine,
ERROR_MESSAGE() AS ErrorMessage;
IF @@ERROR <> 8134
begin
print 'x';
END CATCH;
GO

/* TRY ...CATCH with TRANSACTION */
USE AdventureWorks2012;
GO
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM Production.Product
WHERE ProductID = 980;
END TRY
BEGIN CATCH
SELECT
ERROR_SEVERITY() AS ErrorSeverity
,ERROR_NUMBER() AS ErrorNumber
,ERROR_PROCEDURE() AS ErrorProcedure
,ERROR_STATE() AS ErrorState
,ERROR_MESSAGE() AS ErrorMessage
,ERROR_LINE() AS ErrorLine;
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;
END CATCH;
IF @@TRANCOUNT > 0
COMMIT TRANSACTION;
GO



/* Error State is there to pin point the location where error occured 
in your code. Say if you have a 1000 lines long stored procedure and 
you are raising errors in different places, Error state will help 
you to tell which error was actually raised.


Error Severity gives information about the type of error that occured,
upto Severity level 10 are informational messages.

11-16 are considered errors that can be fixed by the user.

17-19 are considered Non-Fatal errors in Sql Server Resources, Engine and other stuff .

20-25 are considered Fatal Error which causes sql server to shut down the process immediately.
*/

/* @@ERROR
==> @@ERRORfunction returns the error number for the last Transact-SQL statement executed.

*/
USE AdventureWorks2012;
GO
BEGIN TRY
UPDATE HumanResources.EmployeePayHistory
SET PayFrequency = 4
WHERE BusinessEntityID = 1;
END TRY
BEGIN CATCH
IF @@ERROR = 547
PRINT 'Check constraint violation has occurred.';
END CATCH

/*ERROR_STATE
==> ERROR_STATE system function returns the state number of the error that causes the CATCH
block of a TRY…CATCH construct to execute
*/
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_STATE() AS ErrorState;
END CATCH;
GO

/* ERROR_SEVERITY
==> ERROR_SEVERITY function returns the severity of the error that causes the CATCH
block of a TRY…CATCHconstruct to be executed
*/

BEGIN TRY
SELECT 217/0;
BEGIN CATCH
SELECT ERROR_SEVERITY() AS ErrorSeverity;
END CATCH;
GO
END TRY

/* ERROR_PROCEDURE
==> ERROR_PROCEDURE function returns the trigger or a stored procedure name where the error has 
occurred that has caused the CATCH block of a TRY…CATCH construct to be executed.
*/

USE AdventureWorks2012;
GO
IF OBJECT_ID ( 'usp_Example', 'P' ) IS NOT NULL
DROP PROCEDURE usp_Example;
GO
CREATE PROCEDURE usp_Example
AS SELECT 217/0;
GO
BEGIN TRY
EXECUTE usp_Example;
END TRY
BEGIN CATCH
SELECT ERROR_PROCEDURE() AS ErrorProcedure;
END CATCH;
GO


USE tempdb;
GO
CREATE TABLE dbo.TestRethrow
( ID INT PRIMARY KEY
);
BEGIN TRY
INSERT dbo.TestRethrow(ID) VALUES(1);
INSERT dbo.TestRethrow(ID) VALUES(1);
END TRY
BEGIN CATCH
PRINT 'In catch block.';
THROW;
END CATCH;