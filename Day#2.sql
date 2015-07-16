select * from Emp;

/*FUNCTIONS*/
/*#34 avg function*/
select FirstName, LastName from Emp 
WHERE Salary > (select AVG(Salary)from Emp );


/*max min and sum #36 to #38*/
SELECT MAX(Salary)  AS [max salary] FROM Emp;
select FirstName, Salary from Emp
where Salary < (SELECT MAX(Salary) FROM Emp);

SELECT AS min_salary MIN(Salary) FROM Emp ;
select FirstName, Salary from Emp
where Salary > (SELECT MIN(Salary) FROM Emp);

SELECT SUM(Salary) AS SumSalary FROM Emp;

/*#35 and #39*/
/*first create the table DEPARTMENT*/

CREATE TABLE Department (
DepId INT NOT NULL ,
DepName VARCHAR(50),
IdEmp INT 
)

INSERT INTO Department
VALUES(201,'UI',1);
INSERT INTO Department
VALUES(201,'UI',2);
INSERT INTO Department
VALUES(202,'JAVA',3);
INSERT INTO Department
VALUES(203,'DOTNET',4);
INSERT INTO Department
VALUES(203,'DOTNET',5);

SELECT * FROM Department;
 /*add column of department into emp*/
 ALTER TABLE Emp
ADD DId int;

UPDATE Emp
SET DId = 201 WHERE EmpId = 1;
UPDATE Emp
SET DId = 201 WHERE EmpId = 2;
UPDATE Emp
SET DId = 202 WHERE EmpId = 3;
UPDATE Emp
SET DId = 203 WHERE EmpId = 4;
UPDATE Emp
SET DId = 203 WHERE EmpId = 5;

SELECT * FROM Emp;
SELECT * FROM Department;

/*count and group by*/
/*SELECT DepName, COUNT (EmpId);*/
SELECT DepName, COUNT (EmpId)
FROM Department, Emp
WHERE EmpId = IdEmp
GROUP BY DepName;

/*#41 #41 UPPER lower*/
SELECT FirstName, upper(LastName) AS Surname
FROM Emp;

SELECT lower(LastName) AS Surname
FROM Emp;

/*#43 len*/
SELECT FirstName, LEN(FirstName) FROM Emp;

/* #44 round */
SELECT Salary, PF, ROUND(PF,0) AS RoundedPrice
FROM Emp;

/*#45 getdate*/
SELECT *, GETDATE() AS CurrentDate
FROM Emp; 

/*#46 convert*/
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),103) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),104) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),105) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),106) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),107) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),108) FROM Emp;
SELECT FirstName, Salary, CONVERT(VARCHAR(19),GETDATE(),109) FROM Emp;

/*#47 cast*/
SELECT FirstName, CAST( EmpId AS VARCHAR(19)) AS EMPID from Emp;


/*#48 case statement*/
--add age column
ALTER TABLE Emp
ADD Age int;

UPDATE Emp
SET Age = 20 WHERE EmpId = 1;
UPDATE Emp
SET Age = 30 WHERE EmpId = 2;
UPDATE Emp
SET Age = 40 WHERE EmpId = 3;
UPDATE Emp
SET Age = 50 WHERE EmpId = 4;
UPDATE Emp
SET Age = 60 WHERE EmpId = 5;

SELECT FirstName, Age, Salary,
CASE 
     WHEN Salary > 50000 AND Age > 35 
     THEN 'yes' 
     ELSE 'no' 
END "salary status"
from Emp;

/*#49 RANKING FUNCTIONS*/

SELECT FirstName, Salary FROM Emp;
/*TOP 3 HIGHEST PAID EMPLOYEES*/
--method1
SELECT TOP 3 FirstName, Salary FROM Emp ORDER BY Salary DESC;

--method2
SELECT TOP 1 salary
FROM (
SELECT  TOP 5 salary
FROM Emp
ORDER BY Salary DESC) alias
ORDER BY Salary;

--without using top
SELECT * FROM (SELECT FirstName,LastName,Salary,RANK()
OVER(ORDER BY Salary DESC) AS Rank
 FROM Emp) 
AS Temp  WHERE Temp.Rank < 4;


/*alternate highest salaries*/
SELECT * FROM (SELECT FirstName,LastName,Salary,ROW_NUMBER()
OVER(ORDER BY Salary DESC) AS AlternateRank FROM Emp) 
AS Temp  WHERE Temp.AlternateRank %2 = 1;



/*#50 common table expression*/
With CTE_Test (col1, col2, col3)
AS 
(
select FirstName, LastName, Salary
FROM Emp
)
select * from CTE_Test;

/*#51 with roll up with cube*/
--rollup
SELECT DepName, COUNT(EmpId) as TotalEmployees ,SUM(Salary)
FROM Department, Emp
WHERE EmpId = IdEmp 
GROUP BY DepName, EmpId with rollup; 

--cube
SELECT DepName, COUNT(EmpId) as TotalEmployees ,SUM(Salary)
FROM Department, Emp
WHERE EmpId = IdEmp 
GROUP BY DepName, EmpId with cube; 

/*#52 freshers (<6 months)*/
select * from Emp;

SELECT *
FROM Emp
EXCEPT
SELECT *
FROM Emp ;

SELECT *
FROM Emp
INTERSECT
SELECT *
FROM Emp ;

/* #53 correlated subqueries (nested)*/
SELECT TOP 1 salary
FROM (
SELECT  TOP 5 salary
FROM Emp
ORDER BY Salary DESC) alias
ORDER BY Salary;

SELECT * FROM (SELECT FirstName,LastName,Salary,RANK()
OVER(ORDER BY Salary DESC) AS Rank
 FROM Emp) 
AS Temp  WHERE Temp.Rank < 4;

/*#54 running aggregates*/


