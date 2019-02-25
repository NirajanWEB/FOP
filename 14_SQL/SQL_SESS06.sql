/* ----- CREATING DATABASE ------ */
CREATE DATABASE [Customer_DB] 
ON PRIMARY ( NAME = 'Customer_DB', 
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Customer_DB.mdf') 
LOG ON ( NAME = 'Customer_DB_log', 
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Customer_DB_log.ldf') 
COLLATE SQL_Latin1_General_CP1_CI_AS
/*
==> ON : indicates the disk files to be used to store the data sections of the database and data files.
==> PRIMARY : defines the primary file
==> LOG ON: indicates disk files to be used for storing the database log and log files
==> COLLATE : A collation defines rules for comparing and sorting character data based on the standard 
	of particular language and locale.
==> SQL_Latin1_General_CP1_CI_AS : 
	latin1 : makes the server treat strings using charset latin 1, basically ascii
	CP1 : stands for Code Page 1252
	CI : case insensitive comparisons so 'ABC' would equal 'abc'
	AS :  accent sensitive, so 'ü' does not equal 'u'
*/


/* ------- MODIFYING DATABASE -------- */
ALTER DATABASE Customer_DB MODIFY NAME = CUST_DB 

/* ------- OWNERSHIP OF DATABASE ------- */
USE CUST_DB 
EXEC sp_changedbowner 'sa'

/* ------- SETTING DATABASE OPTION ------ */
USE CUST_DB; 
ALTER DATABASE CUST_DB 
SET AUTO_SHRINK ON
/* AUTO_SHRINK options when set to ON, shrinks the database that have free space */


/* ------- Adding Filegroups to an existing Database ------- */
CREATE DATABASE [SalesDB] 
ON PRIMARY ( NAME = 'SalesDB', 
FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SalesDB.mdf' , 
SIZE = 4096KB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 1024KB ), 
FILEGROUP [MyFileGroup] 
( NAME = 'SalesDB_FG', 
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SalesDB_FG.ndf' , 
SIZE = 4096KB , 
MAXSIZE = UNLIMITED, 
FILEGROWTH = 1024KB ) 
LOG ON ( NAME = 'SalesDB_log', 
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SalesDB_log.ldf' , 
SIZE = 4096KB , 
MAXSIZE = 2048GB , 
FILEGROWTH = 10%) 
COLLATE SQL_Latin1_General_CP1_CI_AS 

/* Following code snippet shows how to add a filegroup to an existing database, called CUST_DB: */
USE CUST_DB; 
ALTER DATABASE CUST_DB 
ADD FILEGROUP FG_READONLY

/*------- Default Filegroup -------*/
USE CUST_DB 
ALTER DATABASE CUST_DB 
ADD FILE (
NAME = Cust_DB1, 
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Cust_DB1.ndf') 
TO FILEGROUP FG_ReadOnly 
ALTER DATABASE CUST_DB 
MODIFY FILEGROUP FG_ReadOnly DEFAULT


/*-----  --------*/
