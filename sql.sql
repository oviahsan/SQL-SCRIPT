Create Table Employee (Id int PRIMARY KEY, 
                       LastName varchar (20), 
                       FirstName Varchar(20), 
                       Department varchar(20), 
                       Date_of_Birth Date, 
                       Gender int)

Create Table Gender(ID int,
                   Gender varchar (10))
                   
Alter TABLE Gender
ALTER COLUMN ID INT NOT NULL


Alter TABLE Gender 
add PRIMARY KEY (ID)


Alter table Employee
ADD CONSTRAINT FK_Gender Foreign KEY (gender) REFERENCES Gender (id)

INSERT into Gender VALUES 
(01, 'Male'),
				(02, 'Female')

INSERT into Employee VALUES 
(01, 'Habib', 'Ahsan', 'IT', '10/12/1990', 1),
			(02, 'Ety', 'Ety', 'Admin', '10/10/1995', 2),
(03, 'Habib', 'Ayzaan', 'Director', '11/09/2021', 1),
(04, 'Eshaal', 'Anabia', 'Finance', '02/03/2019', 2),
(05, 'Mahmud','Jahin','Admin','05/06/2000',2)

CREATE INDEX IX_LastName on Employee (LastName)

select * from Employee WHERE lastname='Habib'

DROP INDEX IX_LastName on Employee



CREATE Procedure SP_EmployeeList
AS
BEGIN
 SELECT * FROM Employee
End
EXEC SP_EmployeeList


DECLARE @find as varchar(20)
 set @find = 'A%'
 Select * from Employee WHERE firstname LIKE @find


CREATE view tableview as 
SELECT date_of_birth from Employee where Id=3

SELECT * from tableview



CREATE view olderemployee as 
SELECT lastname, date_of_birth from Employee where date_of_birth > '10/10/2000'

SELECT * from olderemployee



CREATE table Employee2 (id int PRIMARY key, LastName varchar (20), FirstName Varchar(20), department Varchar(10), date_of_birth date, gender int )


SELECT * into Employee3 From Employee

Insert into Employee2 VALUES (09, 'New', 'Employee', 'IT', '10/10/2002', 2)

select * from Employee 


select * from Employee 
JOIN Gender on Employee.Gender=Gender.ID

select Employee.lastname, Gender.Gender from Employee 
JOIN Gender on Employee.Gender=Gender.ID


SELECT * from Employee 
UNION ALL
SELECT * From Employee2


Create view Ahsan as
Select Firstname from empouy


Alter table Gender 
Add constraint FK foregine 



UPDATE Employee 
set lastname='Habib MD' WHERE lastname='Habib'




CREATE function dbo.Fun_Dept (@dep Varchar(10))
RETURNS TABLE
AS
RETURN (SELECT * from Employee where department=@dep)


SELECT * from dbo.Fun_Dept('Admin')


DROP function dbo.Fun_Dept




CREATE table Account_Balance(Account_Number int not null, Balance decimal(18,2) not null)

CREATE table Account_Payments (Date date not null, Account_Number int not null, Payment decimal (18,2) not null)

INSERT INto Account_Balance VALUES (1, 100.00), (2, 150.00), (3, 200.00), (4, 250.00), (5, 1000.00), (6, 5000.00)

INSERT INTO Account_Payments VALUES ('2021-02-06', 1, 50.00), 
('2021-02-06', 2, 25.00), ('2021-02-06', 2, 125.00), 
('2021-02-06', 3, 100.00), ('2021-02-06', 5, 500.00), 
('2021-02-06', 6, 250.00), ('2021-02-06', 6, 250.00)


SELECT account_number, balance from Account_Balance where account_number in (1,2)

Select * from Account_Payments where Account_Number in (1,2)



Update a set a.balance = a.balance - b.payment from Account_Balance a

INNER JOIN Account_Payments b on a.Account_Number=B.Account_Number
WHERE A.Account_Number IN (1,2)

SELECT account_number, balance from Account_Balance where account_number in (1,2)







DECLARE @AccountNumber INT
DECLARE @Payment decimal (18,2)

DECLARE PAYMENT_CURSOR CURSOR FOR
	SELECT account_number, payment 
     From Account_Payments
OPEN PAYMENT_CURSOR 
FETCH NEXT FROM PAYMENT_CURSOR INTO @AccountNumber, @Payment 

WHILE @@FETCH_STATUS = 0
BEGIN
	Update Account_Balance 
      set Balance = Balance - @Payment  
	WHERE account_number = @AccountNumber
    
    FETCH NEXT FROM PAYMENT_CURSOR INTO @AccountNumber, @Payment

END
CLOSE PAYMENT_CURSOR
DEALLOCATE PAYMENT_CURSOR

SELECT * FROM Account_Balance where account_number in (1,2)
