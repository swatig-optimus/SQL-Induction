/* #58 Triggers*/
CREATE TABLE Employee_salary (
EmpId INT UNIQUE,
Basicc INT NOT NULL,
HR INT NOT NULL,
DA INT NOT NULL,
Gross INT DEFAULT NULL
)

INSERT INTO Employee_salary (EmpId, Basicc, HR, DA)
VALUES(1, 1000, 500, 500);

INSERT INTO Employee_salary (EmpId, Basicc, HR, DA)
VALUES(2,31000, 700, 500);

INSERT INTO Employee_salary (EmpId, Basicc, HR, DA)
VALUES(3, 5000, 800, 500);

select * FROM Employee_salary;
--drop TABLE Employee_salary;

CREATE TRIGGER Trigger_GrossSalary
ON Employee_salary 
AFTER INSERT 
AS
BEGIN
UPDATE Employee_salary 
SET Gross = (Basicc+HR+DA)* 12;
END;
select * FROM Employee_salary;


/*#59 cursors*/
TRUNCATE TABLE Employee_salary;
/*DECLARE 
CURSOR cursor_gross IS
SELECT EmpId, Basicc, HR, DA FROM Employee_salary
C1 cursor_gross%ROWTYPE;
 BEGIN
        OPEN cursor_gross;
        LOOP
        FETCH cursor_gross INTO C1;
        EXIT when
        END LOOP; 
    END; */
    
 declare 
@cBasicc int,
@cHR int,
@cDA int;

declare 
cemployeesalary cursor 
for select Basicc,HR,DA from Employee_salary;

open cemployeesalary;

fetch next from cemployeesalary
into @cBasicc, @cHR, @cDA;

begin
update Employee_salary
set Gross=(Basicc+HR+DA)*12;
end;

select * from Employee_salary

/*#61 user defined function*/
DECLARE @year INT;
CREATE FUNCTION getLeapYear(@year INT)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @temp VARCHAR(20);
IF(@year%400=0 )
  SET @temp='LEAP YEAR';
ELSE IF(@year%100=0)
	SET @temp= 'NOT A LEAP YEAR';
ELSE IF(@year%4=0)
	SET @temp='LEAP YEAR'; 
ELSE
	SET @temp='NOT A LEAP YEAR';
RETURN @temp;
END;
GO
--call
SELECT dbo.getLeapYear(2000)as Result;
--DECLARE @year int =2000;
--print @year
--print  dbo.getLeapYear(@year) ;

/*#62 stored procedures*/
DECLARE @employeeId INT;
CREATE PROCEDURE GetEmpInfo(@employeeId INT)
AS
BEGIN
SELECT * FROM Emp 
WHERE EmpId = @employeeId 
END;
EXECUTE GetEmpInfo 5;

/*#63 exception handling*/
--select * from sys.messages
CREATE PROCEDURE DivideZero(@Number1 INT,@Number2 INT)
 AS
 BEGIN
BEGIN TRY

SELECT @Number1%@Number2
END TRY
BEGIN CATCH
SELECT
	ERROR_NUMBER() AS ErrorNumber
	,ERROR_SEVERITY() AS ErrorSeverity
	,ERROR_STATE() AS ErrorState
	,ERROR_PROCEDURE() AS ErrorProcedure
	,ERROR_LINE() AS ErrorLine
	,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END
GO
EXECUTE DivideZero @Number1=100, @Number2=0;