/*------ Triggers---------*/
create table Account_Transactions(
ID int,
TNumber int ,
Deposit money,
withdrawal money
)

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


CREATE TRIGGER CheckWithdrawal_Amount1
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


