/*
A transaction is
==> a single unit of work.
==> is successful only when all data modifications that are made in a transaction are 
committed and are saved in the database permanently.

==> If the transaction is rolled back or cancelled, then it means that the transaction 
has encountered errors and there are no changes made to the contents of the database.

==> A transaction can be either committed or rolled back.

*/

/* Starting and Ending Sessions using Transact-SQL 
==> BEGIN TRANSACTION statement marks the beginning point of an explicit or local transaction.
==> COMMIT TRANSACTION statement marks an end of a successful implicit or explicit transaction.
==> ROLLBACK TRANSACTION ==> This transaction rolls back or cancels an implicit or explicit transaction 
to the starting point of the transaction, or to a savepointin a transaction.
*/
/* COMMIT */
BEGIN TRANSACTION DeleteCandidate
WITH MARK 'Deleting a Job Candidate';
GO
DELETE FROM HumanResources.JobCandidate
WHERE JobCandidateID= 11;
GO
COMMIT TRANSACTION DeleteCandidate;

/* ROLLBACK */
USE CUST_DB;
GO
CREATE TABLE ValueTable([value] char)
GO

BEGIN TRANSACTION
INSERT INTO ValueTable VALUES('A');
INSERT INTO ValueTable VALUES('B');
GO
ROLLBACK TRANSACTION
INSERT INTO ValueTable VALUES('C');
SELECT [value] FROM ValueTable;


/* SAVE TRANSACTION 
==> statementsets a savepoint within a transaction. */
CREATE PROCEDURE SaveTranExample
@InputCandidateID INT
AS
DECLARE @TranCounter INT;
SET @TranCounter= @@TRANCOUNT;
IF @TranCounter> 0
SAVE TRANSACTION ProcedureSave;
ELSE
BEGIN TRANSACTION;
DELETE HumanResources.JobCandidate
WHERE JobCandidateID= @InputCandidateID;
IF @TranCounter= 0
COMMIT TRANSACTION;
IF @TranCounter= 1
ROLLBACK TRANSACTION ProcedureSave;
GO

/* @@TRANCOUNT 
==> @@TRANCOUNTsystem function returns a number of BEGIN TRANSACTION
statements that occur in the current connection.
*/

PRINT @@TRANCOUNT
BEGIN TRAN
PRINT @@TRANCOUNT
BEGIN TRAN
PRINT @@TRANCOUNT
COMMIT
PRINT @@TRANCOUNT
COMMIT
PRINT @@TRANCOUNT