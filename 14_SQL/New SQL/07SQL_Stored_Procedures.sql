/* 
STORED PROCEDURE:
==> A stored procedure is a prepared SQL code that you can save, 
so the code can be reused over and over again.
*/

/* ------ Create Stored procedure ------*/
USE AdventureWorks2012;  
GO  
CREATE PROCEDURE sp_HumanResources 
    @LastName varchar(50),   
    @FirstName varchar(50)   
AS   

    SET NOCOUNT ON;  
    SELECT FirstName, LastName, Department  
    FROM HumanResources.vEmployeeDepartmentHistory  
    WHERE FirstName = @FirstName AND LastName = @LastName  
    AND EndDate IS NULL;  
GO  

/* 
==> When SET NOCOUNT is ON, the count is not returned. 
==> When SET NOCOUNT is OFF, the count is returned.
==> SET NOCOUNT ON prevents the sending of DONE_IN_PROC messages to 
the client for each statement in a stored procedure
==> setting SET NOCOUNT to ON can provide a significant performance boost, 
because network traffic is greatly reduced.
*/

/* -------- Execute Stored Procedure ---------*/
EXECUTE sp_HumanResources 'Ackerman', 'Pilar';  
-- Or  
EXEC sp_HumanResources @LastName = 'Ackerman', @FirstName = 'Pilar';  
-- Or  
EXECUTE sp_HumanResources @FirstName = 'Pilar', @LastName = 'Ackerman';

/* ------------ Stored Procedure for select, insert, update and delete ------------*/
USE CUST_DB
CREATE TABLE employee(    
id INTEGER NOT NULL PRIMARY KEY,    
first_name VARCHAR(10),  
last_name VARCHAR(10),  
salary DECIMAL(10,2),  
city VARCHAR(20),  
)   

INSERT INTO employee VALUES (2, 'Monu', 'Rathor',4789,'Agra');  
GO
INSERT INTO employee VALUES (4, 'Rajiv' , 'Saxena', 5567,'London');  
GO
INSERT INTO employee VALUES (5, 'prabhat', 'kumar', 4467,'Bombay');  
Go
INSERT INTO employee VALUES (6, 'ramu', 'kksingh', 3456, 'jk');
Go
  
create PROCEDURE sp_MasterInsertUpdateDelete
(  
@id INTEGER,  
@first_name VARCHAR(10),  
@last_name VARCHAR(10),  
@salary DECIMAL(10,2),  
@city VARCHAR(20),  
@StatementType nvarchar(20) = ''  
)  
AS 
SET NOCOUNT ON; 
BEGIN  
IF @StatementType = 'Insert'  
BEGIN  
insert into employee (id,first_name,last_name,salary,city) 
values( @id, @first_name, @last_name, @salary, @city)  
END  
IF @StatementType = 'Select'  
BEGIN  
select * from employee  
END  
IF @StatementType = 'Update'  
BEGIN  
UPDATE employee SET  
First_name = @first_name, last_name = @last_name, salary = @salary,  
city = @city  
WHERE id = @id  
END  
else IF @StatementType = 'Delete'  
BEGIN  
DELETE FROM employee WHERE id = @id  
END  
end  

execute sp_MasterInsertUpdateDelete 7,'rajan','khadka',1000.22,'ktm','Insert'
execute sp_MasterInsertUpdateDelete 7,'rajan','khadka',1000.22,'ktm','Select'
execute sp_MasterInsertUpdateDelete 7,'raja','khadk',1000.23,'ktmm','Update'
execute sp_MasterInsertUpdateDelete 7,'rajan','khadka',1000.22,'ktm','Delete'

select * from employee

-- Dropping stored procedure
Drop procedure sp_MasterInsertUpdateDelete