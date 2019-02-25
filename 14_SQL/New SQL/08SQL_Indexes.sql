/*
INDEXES:
==> Indexes are used to retrieve data from the database very fast. 
==> The users cannot see the indexes, they are just used to speed up searches/queries.
==> Updating a table with indexes takes more time than updating a table without 
(because the indexes also need an update). 
==> So, only create indexes on columns that will be frequently searched against.
*/

/*-------- Creating Indexes ---------*/
USE CUST_DB 
CREATE INDEX IX_Country ON Product_Details(ProductID); 
-- Product_Details table created in views session

/* -------- INDEX TYPE : CLUSTERED and NONCLUSTERED ---------*/
/* 
==> A clustered index is a special type of index that reorders the way records 
 in the table are physically stored.
==> Therefore table can have only one clustered index.

==> A nonclustered index is a special type of index in which the logical order 
 of the index does not match the physical stored order of the rows on disk.
*/

/*-------- Creating Clustered Index --------*/
USE CUST_DB 
CREATE CLUSTERED INDEX IX_CustID ON Product_Details(ProductID); 


/*-------- Creating Non Clustered Index ----------*/
USE CUST_DB 
CREATE NONCLUSTERED INDEX IX_State ON Product_Details(ProductName); 

/*-------- Dropping Index -------------------------*/
DROP INDEX IX_Cust
ID ON Product_Details

