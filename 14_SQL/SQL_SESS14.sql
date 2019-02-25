/*------- Transcaction ---------*/
USE AdventureWorks2012;
GO
DECLARE @TranNameVARCHAR(30);
SELECT @TranName= 'FirstTransaction';
BEGIN TRANSACTION @TranName;
DELETE FROM HumanResources.JobCandidate
WHERE JobCandidateID= 13;


/*------- @@TRANCOUNT-----------*/
PRINT @@TRANCOUNT
BEGIN TRAN
PRINT @@TRANCOUNT
BEGIN TRAN
PRINT @@TRANCOUNT
COMMIT
PRINT @@TRANCOUNT
COMMIT
PRINT @@TRANCOUNT