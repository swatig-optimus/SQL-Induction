/*CrEATING DATABASE*/
CREATE DATABASE Db_Emp;

/*CREATING TABLE EMP*/
CREATE TABLE Emp (
EmpId INT NOT NULL PRIMARY KEY CHECK (EmpId > 0 ),
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50),
Gender VARCHAR(1) DEFAULT 'M',
ActiveStatus BIT DEFAULT '1'
)
select * from Emp;

/*entering values into the table*/
INSERT INTO Emp
VALUES('1','Swati','Gakhar','F',0);
INSERT INTO Emp
VALUES(02,'Nipun','Chawla','M','0');
INSERT INTO Emp
VALUES(03,'Rishabh','Sethi','M','1');
INSERT INTO Emp
VALUES(04,'Aastha','Sharma','F','1');
INSERT INTO Emp
VALUES(05,'Vaishali','Taneja','F','1');
select * from Emp;

/*create and drop table*/
CREATE TABLE Desig (
Name varchar(50) NOT NULL,
)
DROP TABLE Desig;


/*creating index and unique index*/
CREATE UNIQUE INDEX index_Emp
ON Emp (FirstName);

CREATE UNIQUE INDEX UniqueIndex_Emp
ON Emp (FirstName, LastName);

/*creating table designation*/
CREATE TABLE Designation (
DesignationId int NOT NULL PRIMARY KEY,
DesignationName varchar(20)
)

/*adding a new column into the table emp*/
ALTER TABLE Emp
ADD EmpDesignationId int FOREIGN KEY REFERENCES Designation(DesignationId);

/*entering values into the new table*/
INSERT INTO Designation
VALUES(100,'alpha');
INSERT INTO Designation
VALUES(101,'beta');
INSERT INTO Designation
VALUES(102,'gamma');
INSERT INTO Designation
VALUES(103,'theta');
INSERT INTO Designation
VALUES(104,'omega');


/*adding new column into emp*/
ALTER TABLE Emp
ADD Salary int;

UPDATE Emp
SET Salary=25000 WHERE EmpId=1;

UPDATE Emp
SET Salary=35000 WHERE EmpId=2;

UPDATE Emp
SET Salary=45000 WHERE EmpId=3;

UPDATE Emp
SET Salary=55000 WHERE EmpId=4;

UPDATE Emp
SET Salary=65000 WHERE EmpId=5;

SELECT * FROM Emp;

/*IN*/
SELECT Salary
FROM Emp
WHERE Salary IN (25000, 55000);

/*between*/
SELECT Salary
FROM Emp
WHERE Salary BETWEEN 25000 AND 55000;

/*alias*/
SELECT Gender AS Sex
FROM Emp;


/*select into*/
CREATE DATABASE DummyDB;

SELECT *
INTO EmpBackup2015 IN 'DummyDB'
FROM Emp;

/*increment*/
UPDATE emp
 SET Salary = Salary + 500;
 
 SELECT * FROM Emp;
 
 /*VIEW*/
 CREATE VIEW view_Emp AS
SELECT Salary
FROM Emp
WHERE (Salary > 60000);

SELECT * FROM view_Emp;

ALTER TABLE Emp
ADD DOJ DATETIME ;

ALTER TABLE Emp
ALTER COLUMN DOJ DATE;

SELECT * FROM Emp;

/*entering doj into the emp*/
UPDATE Emp
SET DOJ= '19960725' WHERE EmpId=1;
SELECT DOJ FROM Emp;
UPDATE Emp
SET DOJ= '19960726' WHERE EmpId=2;
UPDATE Emp
SET DOJ= '19960727' WHERE EmpId=3;
UPDATE Emp
SET DOJ= '19960728' WHERE EmpId=4;
UPDATE Emp
SET DOJ= '19960729' WHERE EmpId=5;

SELECT * FROM Emp;

/*DATES*/
SELECT DATE(NOW(),'%a %D %b %y %h:%i %p');

/*sum with null #30*/
ALTER TABLE Emp
ADD CarNum int DEFAULT 'null';

UPDATE Emp
SET CarNum= 1 WHERE EmpId=1;
UPDATE Emp
SET CarNum= 2 WHERE EmpId=2;
UPDATE Emp
SET CarNum= 1 WHERE EmpId=4;
select * from Emp;

SELECT SUM(CarNum) AS total FROM Emp;

/*is null #31*/
SELECT LastName,FirstName FROM Emp
WHERE LastName IS NULL

/*datatypes #32*/
ALTER TABLE Emp
ADD PF decimal DEFAULT 'null';

UPDATE Emp
SET PF = 0.1275*Salary;
select * from Emp;


