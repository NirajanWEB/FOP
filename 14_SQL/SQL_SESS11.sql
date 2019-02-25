/*-------- Creating Indexes ---------*/
USE CUST_DB 
CREATE INDEX IX_Country ON Product_Details(ProductID); 

/*-------- Creating Clustered Index --------*/
USE CUST_DB 
CREATE CLUSTERED INDEX IX_CustID ON Product_Details(ProductID);

/*-------- Creating Non Clustered Index ----------*/
USE CUST_DB 
CREATE NONCLUSTERED INDEX IX_State ON Product_Details(ProductName); 

/*-------- Dropping Index -------------------------*/
DROP INDEX IX_CustID ON Product_Details WITH (MOVE TO 'default')

/*--------Primary XML Indexes -----------------------------*/
USE AdventureWorks2012; 
CREATE PRIMARY XML INDEX PXML_ProductModel_CatalogDescription 
ON Production.ProductModel (CatalogDescription); 
GO

/*--------Secondary XML Indexes -----------------------------*/
USE AdventureWorks2012; 
CREATE XML INDEX IXML_ProductModel_CatalogDescription_Path 
ON Production.ProductModel (CatalogDescription) 
USING XML INDEX PXML_ProductModel_CatalogDescription FOR PATH ; 
GO

/*-------- Altering XML Indexes --------------------------*/
ALTER INDEX PXML_ProductModel_CatalogDescription ON Production.ProductModel REBUILD

/*-------- Droping XML Indexes ---------------------------*/
DROP INDEX PXML_ProductModel_CatalogDescription ON Production.ProductModel

/*-------- Finding Rows ---------------------------------*/
USE CUST_DB 
CREATE TABLE Employee_Details ( 
EmpID int not null, 
FirstName varchar(20) not null, 
LastName varchar(20) not null, 
DateofBirth datetime not null, 
Gender varchar(6) not null, 
City varchar(30) not null, 
) 
GO

Insert into Employee_Details  values (1,'ram','prasad','1990-12-12','M','ktm')
Insert into Employee_Details values (2,'john','abraham','1991-12-12','M','brt')
Insert into Employee_Details values (3,'shyam','kumar','1992-12-12','M','pkr')
Insert into Employee_Details values (4,'babu','raw','1993-12-12','M','rjb')
Insert into Employee_Details values (5,'gian','mustafa','1990-01-12','M','bkt')
Insert into Employee_Details values (6,'anil','ambani','1990-02-12','M','ktm')
Insert into Employee_Details values (7,'gita','kumari','1990-12-13','F','ktm')
Insert into Employee_Details values (8,'sita','ram','1990-12-14','F','ktm')

/*----- Finding Rows with non clustered Index-------*/
CREATE NONCLUSTERED INDEX IX_EmployeeCity ON Employee_Details(City); 

SELECT EmpID,FirstName,LastName,City FROM Employee_Details WHERE City='ktm'
drop index IX_EmployeeCity On Employee_Details


/*----- Finding Rows with clustered Index-------*/
CREATE CLUSTERED INDEX IX_EmployeeID ON Employee_Details(EmpID);

SELECT EmpID,FirstName,LastName,City FROM Employee_Details WHERE EmpID >= 1 AND EmpID <= 4;

/*------ Create Computed Column ---------------*/
USE CUST_DB 
CREATE TABLE Calc_Area(Length int, Breadth int, Area AS Length*Breadth) 

/*------ Creating Index on computed column ----------*/
CREATE INDEX IX_Area ON Calc_Area(Area); 

/*-------- Cursors --------------*/
USE CUST_DB 
CREATE TABLE Employee ( 
EmpID int PRIMARY KEY, 
EmpName varchar (50) NOT NULL, 
Salary int NOT NULL, 
Address varchar (200) NOT NULL, 
) 
GO
INSERT INTO Employee(EmpID,EmpName,Salary,Address) VALUES(1,'Derek',12000,'Housten') 
INSERT INTO Employee(EmpID,EmpName,Salary,Address) VALUES(2,'David',25000,'Texas') 
INSERT INTO Employee(EmpID,EmpName,Salary,Address) VALUES(3,'Alan',22000,'New York') 
INSERT INTO Employee(EmpID,EmpName,Salary,Address) VALUES(4,'Mathew',22000,'las Vegas') 
INSERT INTO Employee(EmpID,EmpName,Salary,Address) VALUES(5,'Joseph',28000,'Chicago') 
GO 
SELECT * FROM Employee 

USE CUST_DB 
SET NOCOUNT ON 
DECLARE @Id int 
DECLARE @name varchar(50) 
DECLARE @salary int 
/* A cursor is declared by defining the SQL statement that returns a resultset.*/ 
DECLARE cur_emp CURSOR 
STATIC FOR 
SELECT EmpID,EmpName,Salary from Employee 
/*A Cursor is opened and populated by executing the SQL statement defined by the cursor.*/ 
OPEN cur_emp IF @@CURSOR_ROWS > 0 BEGIN 
/*Rows are fetched from the cursor one by one or in a block to do data manipulation*/ 
FETCH NEXT FROM cur_emp INTO @Id,@name,@salary WHILE @@Fetch_status = 0 
BEGIN 
PRINT 'ID : '+ convert(varchar(20),@Id)+', Name : '+@name+ ', Salary : '+convert(varchar(20),@salary) 
FETCH NEXT FROM cur_emp INTO @Id,@name,@salary END 
END 
--close the cursor explicitly 
CLOSE cur_emp 
/*Delete the cursor definition and release all the system resources associated with the cursor*/ 
DEALLOCATE cur_emp 
SET NOCOUNT OFF