/* ------------------ Triggers --------------------*/
/* A trigger:
==> is a stored procedure that is executed when an attempt is made to modify data in a 
table protected by the trigger.
==> cannot be executed directly, nor do they pass or receive parameters.
==> is defined on specific tables and these tables are referred to as trigger tables.
==> is defined on the INSERT, UPDATE, or DELETE action on a table, it fires automatically 
when these actions are attempted.
==> is created using the CREATE TRIGGER statement.
*/

USE CUST_DB
create table Account_Transactions(
ID int,
TNumber int ,
Deposit money,
withdrawal money
)

/* -------------------- Insert Trigger ---------------------- */
CREATE TRIGGER CheckWithdrawal_Amount
ON Account_Transactions
FOR INSERT
AS
IF (SELECT Withdrawal From inserted) > 80000
BEGIN
PRINT 'Withdrawal amount cannot exceed 80000'
ROLLBACK TRANSACTION
END

Insert into Account_Transactions values (101,1008,120000,100000)

/* -------------------- Update Trigger ---------------------- */
CREATE TRIGGER CheckWithdrawal_Amount1
ON Account_Transactions
FOR UPDATE
AS
IF (SELECT Withdrawal From inserted) > 80000
BEGIN
PRINT ' amount cannot exceed 80000'
ROLLBACK TRANSACTION
END

update Account_Transactions
set Withdrawal = 80001
where id = 101

/* -------------------- Delete Trigger ----------------------- */
CREATE TRIGGER CheckWithdrawal_Amount2
ON Account_Transactions
FOR DELETE
AS
IF  8000 in (SELECT Deposit From deleted)
BEGIN
PRINT 'amount cannot be deleted'
ROLLBACK TRANSACTION
END

delete from Account_Transactions
where Deposit = 8000

/* -------------------- After Trigger -------------------------*/
/*
==>Is executed on completion of INSERT, UPDATE, or DELETE operations and can be created only on tables.
*/

CREATE TRIGGER Employee_Deletion
ON Account_Transactions
AFTER DELETE
AS
BEGIN
DECLARE @num nchar;
SELECT @num = COUNT(*) FROM deleted
PRINT 'No. of employees deleted = ' + @num
END

delete from Account_Transactions
where Deposit = 120000

/* --------------------- Instead of Triggers ------------------*/
/*
==> Is executed in place of the INSERT, UPDATE, or DELETE operations.
==> Can be created on tables as well as views and there can be only one 
INSTEAD OF trigger defined for each INSERT, UPDATE, and DELETE operation.
==> Are executed before constraint checks are performed on the table and 
after the creation of the Inserted and Deleted tables
*/

USE CUST_DB
CREATE TABLE Employee_Personal_Details ( 
EmpID1 int NOT NULL, 
FirstName varchar(30) NOT NULL, 
LastName varchar(30) NOT NULL, 
Address varchar(30) 
) 

CREATE TABLE Employee_Salary_Details ( 
EmpID2 int NOT NULL, 
Designation varchar(30), 
Salary int NOT NULL 
)

CREATE VIEW vwEmployee_Detailss AS 
SELECT e1.EmpID1, 
e1.FirstName, 
e1.LastName,
e2.EmpID2, 
e2.Designation, 
e2.Salary 
FROM Employee_Personal_Details e1 
JOIN 
Employee_Salary_Details e2 
ON 
e1.EmpID1 = e2.EmpID2

create trigger employee on vwEmployee_Detailss
instead of insert
	as
	begin
		insert into Employee_Personal_Details (EmpID1, FirstName, LastName)
		select EmpID1,FirstName,Lastname
		from inserted
		insert into Employee_Salary_Details (EmpID2, Designation, Salary)
		select EmpID2, Designation, Salary
		from inserted
	end
 
INSERT INTO vwEmployee_Details VALUES (2,'Jack','Wilson',2,'Software Developer',16000)

select *from vwEmployee_Details