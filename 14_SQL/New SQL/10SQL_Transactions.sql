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
to the starting point of the transaction, or to a savepoint in a transaction.
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
==> statement sets a savepoint within a transaction. */
USE CUST_DB
GO
 
CREATE TABLE TestTable
(
   ID INT NOT NULL,
   Value INT NOT NULL,
   PRIMARY KEY (ID)
)
GO	

BEGIN TRANSACTION 
   INSERT INTO TestTable( ID, Value )
   VALUES  ( 1, N'10')
   
   -- this will create a savepoint after the first INSERT
   SAVE TRANSACTION FirstInsert
   
   INSERT INTO TestTable( ID, Value )
   VALUES  ( 2, N'20')
 
   -- this will rollback to the savepoint right after the first INSERT was done
   ROLLBACK TRANSACTION FirstInsert

-- this will commit the transaction leaving just the first INSERT 
COMMIT
 
SELECT * FROM TestTable

/* @@TRANCOUNT 
==> @@TRANCOUNT system function returns a number of BEGIN TRANSACTION
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