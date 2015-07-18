CREATE DATABASE asgnment2;

--Table1

CREATE TABLE T_Emp
(
Emp_Id INT PRIMARY KEY IDENTITY(1001,2),
Emp_Code VARCHAR(20),
Emp_FName VARCHAR(20) NOT NULL,
Emp_MName VARCHAR(20),
Emp_LName VARCHAR(20) NOT NULL,
Emp_DOB DATE CHECK((YEAR(GETDATE())-YEAR(Emp_DOB))>=18),
Emp_DOJ date NOT NULL
);

INSERT INTO T_Emp(Emp_Code,Emp_FName,Emp_MName,Emp_LName,Emp_DOB,Emp_DOJ)
VALUES('OPT20110105','Manmohan','','Singh','1983-02-10','2010-05-25');

INSERT INTO T_Emp(Emp_Code,Emp_FName,Emp_MName,Emp_LName,Emp_DOB,Emp_DOJ)
VALUES('OPT20110105','Alfred','Joseph','Lawrence','1988-02-28','2011-06-24');


SELECT * FROM T_Emp;

--Table2

CREATE TABLE T_Activity
(
Activity_Id INT PRIMARY KEY,
Activity_Description VARCHAR(20)
);

INSERT INTO T_Activity
VALUES('1','Code Analysis');
INSERT INTO T_Activity
VALUES('2','Lunch');
INSERT INTO T_Activity
VALUES('3','Coding');
INSERT INTO T_Activity
VALUES('4','Knowledge Transition');
INSERT INTO T_Activity
VALUES('5','Database');

SELECT * FROM T_Activity;

--Table3

CREATE TABLE T_Atten
(
Atten_Id INT PRIMARY KEY IDENTITY(1001,1),
Emp_Id INT FOREIGN KEY REFERENCES T_Emp(Emp_Id) ,
Activity_Id INT FOREIGN KEY REFERENCES T_Activity(Activity_Id) ,
Atten_StartTime DATETIME,
Atten_EndHrs INT
);

INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1001,5,'2011/2/13 10:00:00',2);
INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1001,1,'2011/1/14 10:00:00',3);
INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1001,3,'2011/1/14 13:00:00',5);
INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1003,5,'2011/2/16 10:00:00',8);
INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1003,5,'2011/2/17 10:00:00',8);
INSERT INTO T_Atten(Emp_Id,Activity_Id,Atten_StartTime,Atten_EndHrs)
VALUES(1003,5,'2011/2/19 10:00:00',7);


SELECT * FROM T_Atten;


--Table 4

CREATE TABLE T_Salary
(
Salary_Id INT PRIMARY KEY,
Emp_Id INT FOREIGN KEY REFERENCES T_Emp(Emp_Id),
Changed_Salary date,
New_Salary FLOAT
);

INSERT INTO T_Salary
VALUES(1001,1003,'2011-02-16',20000.00);
INSERT INTO T_Salary
VALUES(1002,1003,'2011-01-05',25000.00);
INSERT INTO T_Salary
VALUES(1003,1001,'2011-02-16',26000.00);

SELECT * FROM T_Salary;

--Question1

SELECT * FROM(
SELECT Emp_FName+' '+Emp_MName+' '+Emp_LName AS Name,
CASE
WHEN MONTH(Emp_DOB)IN(1,3,5,7,8,10,12) AND DAY(Emp_DOB)=31
THEN Emp_DOB
WHEN MONTH(Emp_DOB)IN(4,6,9,11) AND DAY(Emp_DOB)=30
THEN Emp_DOB
WHEN MONTH(Emp_DOB)=2
AND DAY(Emp_DOB)=28
THEN Emp_DOB
END AS DateOfBirth
FROM T_Emp)AS S
WHERE S.DateOfBirth IS NOT NULL

--Question2

SELECT Emp_FName+' '+Emp_MName+' '+Emp_LName AS Name,
Increment,PreviousSalary,CurrentSalary, TotalWorkedHours,
Sub2.Activity_Id AS LastWorkedId, Sub2.Atten_EndHrs AS LastHourWorked
FROM(
SELECT Emp_Id,
CASE
	WHEN COUNT(Emp_Id)>1 
	THEN 'Yes'
	ELSE 'No'
END AS Increment,
CASE
	WHEN COUNT(Emp_Id)>1 
	THEN MIN(New_Salary)
	ELSE 0
END AS PreviousSalary,
MAX(New_Salary) AS CurrentSalary
FROM T_Salary
GROUP BY Emp_Id) AS Subquery1

JOIN T_Emp
ON T_Emp.Emp_Id=Subquery1.Emp_Id

JOIN
(
SELECT Emp_Id, SUM(Atten_EndHrs)AS TotalWorkedHours
FROM T_Atten
GROUP BY Emp_Id
) AS Subquery2
ON Subquery1.Emp_Id=Subquery2.Emp_Id


JOIN  (SELECT Sub1.Emp_Id,Activity_Id,Atten_EndHrs 
       FROM T_Atten AS Sub1
	   JOIN (SELECT Emp_Id, MAX(Atten_StartTime)m  
	   FROM T_Atten GROUP BY Emp_Id)AS Sub
	   ON Sub.Emp_Id=Sub1.Emp_Id 
	   WHERE Sub1.Atten_StartTime=Sub.m) AS Sub2
ON Sub2.Emp_Id=T_Emp.Emp_Id




