CREATE DATABASE DBCabBook;

USE DBCabBook;

GO
--Create table TVendor

CREATE TABLE TVendor(
VendorID INT PRIMARY KEY ,
Name VARCHAR(20));

INSERT INTO TVendor VALUES(101,'Sai Travels');
INSERT INTO TVendor VALUES(102,'Meru Cabs');
INSERT INTO TVendor VALUES(103,'Miracle Cabs');

SELECT * FROM TVendor;

--Create table Cab

CREATE TABLE TCab(
CabID INT PRIMARY KEY,
VendorID INT CONSTRAINT FKVendor FOREIGN KEY REFERENCES TVendor(VendorID),
Number INT,
BrandName VARCHAR(20));

INSERT INTO TCab VALUES(201, 101, 8529, 'Mercedes');
INSERT INTO TCab VALUES(202, 103, 5764, 'Jaguar');
INSERT INTO TCab VALUES(203, 101, 1967, 'Lamborghini');
INSERT INTO TCab VALUES(204, 102, 7359, 'Mercedes');
INSERT INTO TCab VALUES(205, 103, 1992, 'Audi');
INSERT INTO TCab VALUES(206, 103, 0786, 'BMW');
INSERT INTO TCab VALUES(207, 101, 0007, 'Audi');
INSERT INTO TCab VALUES(208, 102, 8541, 'Fiat');

SELECT * FROM TCab;


--Create table TUser

CREATE TABLE TUser(
UserID INT PRIMARY KEY,
UserName VARCHAR(20),
Gender VARCHAR(2));

INSERT INTO TUser VALUES(301, 'Ravi', 'M');
INSERT INTO TUser VALUES(302, 'Kavi', 'F');
INSERT INTO TUser VALUES(303, 'Abhi', 'M');
INSERT INTO TUser VALUES(304, 'Savita', 'F');
INSERT INTO TUser VALUES(305, 'Gopal', 'M');
INSERT INTO TUser VALUES(306, 'Bhopal', 'M');
INSERT INTO TUser VALUES(307, 'Dolly', 'F');
INSERT INTO TUser VALUES(308, 'Tanu', 'F');
INSERT INTO TUser VALUES(309, 'Prince', 'M');
INSERT INTO TUser VALUES(310, 'Raj Kishore', 'M');

SELECT * FROM TUser;

--Create table TBooking

CREATE TABLE TBooking(
BookingID INT PRIMARY KEY,
CabID INT CONSTRAINT FKCab FOREIGN KEY REFERENCES TCab(CabID),
UserID INT CONSTRAINT FKUser FOREIGN KEY REFERENCES TUser(UserID),
Fare INT,
Distance FLOAT,
PickupTime DATETIME,
DropTime DATETIME,
Rating INT);

INSERT INTO TBooking VALUES(401, 204, 309, 101, 13, '2015-04-07 19:00:00','2015-04-07 19:30:00', 5);
INSERT INTO TBooking VALUES(402, 205, 301, 105, 15.2, '2015-05-11 9:15:00','2015-05-11 10:00:00', 3);
INSERT INTO TBooking VALUES(403, 204, 309, 2000, 190, '2015-03-19 20:45:00','2015-03-20 01:00:00', 2);
INSERT INTO TBooking VALUES(404, 201, 302, 1995, 150, '2015-07-07 11:00:00','2015-07-07 15:00:00', 5);
INSERT INTO TBooking VALUES(405, 204, 303, 553, 50, '2015-09-12 19:00:00','2015-09-12 22:15:00', 2);
INSERT INTO TBooking VALUES(406, 202, 302, 465, 45, '2015-01-07 09:00:00','2015-01-07 09:40:00', 1);
INSERT INTO TBooking VALUES(407, 205, 304, 258, 20, '2015-07-02 03:00:00','2015-07-02 03:15:00', 4);
INSERT INTO TBooking VALUES(408, 202, 309, 125, 15, '2015-06-23 09:00:00','2015-06-23 10:00:00', 5);
INSERT INTO TBooking VALUES(409, 204, 310, 1462, 30, '2015-02-05 06:00:00','2015-02-05 08:00:00', 4);
INSERT INTO TBooking VALUES(410, 207, 306, 1876, 60, '2015-01-29 15:00:00','2015-01-29 18:00:00', 1);
INSERT INTO TBooking VALUES(411, 203, 308, 1145, 100, '2015-06-04 20:00:00','2015-06-05 06:00:00', 0);
INSERT INTO TBooking VALUES(412, 206, 309, 1358, 90, '2015-01-19 02:00:00','2015-01-19 08:00:00', 1);
INSERT INTO TBooking VALUES(413, 208, 301, 102, 5, '2015-03-21 11:00:00','2015-03-21 11:15:00', 5);
INSERT INTO TBooking VALUES(414, 206, 309, 503, 50, '2015-02-28 08:00:00','2015-02-28 10:00:00', 4);
INSERT INTO TBooking VALUES(415, 204, 304, 786, 62, '2015-03-09 16:00:00','2015-03-09 19:00:00', 3);
INSERT INTO TBooking VALUES(416, 208, 306, 143, 3, '2015-04-09 11:30:00','2015-04-09 11:45:00', 2);
INSERT INTO TBooking VALUES(417, 203, 309, 658, 12, '2015-05-04 01:00:00','2015-05-04 01:45:00', 0);
INSERT INTO TBooking VALUES(418, 206, 308, 852, 17, '2015-02-18 15:00:00','2015-02-18 16:00:00', 1);
INSERT INTO TBooking VALUES(419, 208, 301, 450, 22, '2015-03-11 18:00:00','2015-03-12 10:30:00', 4);
INSERT INTO TBooking VALUES(420, 204, 309, 420, 29, '2015-02-17 11:00:00','2015-02-17 21:00:00', 1);

SELECT * FROM TBooking;

--query1

SELECT  UserName, BrandName, Number,TravelTimeMinutes FROM (
SELECT UserName, CabID,TravelTimeMinutes FROM ( 
SELECT UserID,CabID, DateDiff(Mi,PickupTime, DropTime )TravelTimeMinutes FROM TBooking
WHERE Fare BETWEEN 500 AND 1000) as s1
join TUser
on TUser.UserID = s1.UserID ) as s2
join TCab
on TCab.CabID = s2.CabID;



--query2

SELECT Number, BrandName FROM (
SELECT cabid, RANK() over(order by count(cabid) desc)as ranking
from TBooking group by CabID) as s1
join TCab
ON TCab.cabid = s1.CabID
where ranking=1

--query 3

SELECT UserName, ranking FROM (
SELECT UserID, RANK() over(order by count(UserID) desc)as ranking
from TBooking group by UserID) as s1
join TUser
ON TUser.UserID = s1.UserID
where ranking < 4;

--query 6

SELECT VendorID, AVG(AverageRating)VendorRating from (
SELECT CabID, AVG(Rating)AverageRating from TBooking group by CabID) as s1
join TCab 
ON s1.CabID = TCab.CabID
GROUP BY VendorID;

--query 9


SELECT TOP 1 CabID, SUM(Fare)/SUM(Distance) 
FROM TBooking 
GROUP BY CabID 
ORDER BY SUM(Fare)/SUM(Distance);


--query 4
SELECT UserName, Name, CountTimes FROM ( 
   SELECT UserName, VendorID, CountTimes FROM (  
       SELECT s1.UserID, UserName, CabID, CountTimes from (
            SELECT UserID, CabID, COUNT(UserID)CountTimes 
            FROM TBooking GROUP BY UserID, CabID) as s1
  join TUser
  ON TUser.UserID = s1.UserID ) as s2
join TCab
ON TCab.CabID = s2.CabID ) as s3
join TVendor
ON TVendor.VendorID = s3.VendorID 

--query 5

SELECT BrandName, Number, Gender FROM (
SELECT CabID, s1.UserID, Gender FROM (
  SELECT CabID, UserID FROM TBooking GROUP BY UserID, CabID) as s1
JOIN TUser
ON TUser.UserID = s1.UserID
GROUP BY s1.UserID, CabID,  Gender) as s2
join TCab
On s2.CabID = TCab.CabID    


SELECT BrandName, Number, Gender FROM (
SELECT CabID, Gender FROM (
  SELECT CabID, UserID FROM TBooking GROUP BY UserID, CabID) as s1
JOIN TUser
ON TUser.UserID = s1.UserID
GROUP BY CabID,  Gender) as s2
join TCab
On s2.CabID = TCab.CabID 


--query 8

SELECT VendorID, COUNT(s1.CabID)as TotalBookedCabs From Tcab 
join(
SELECT CabID, CONVERT(date, PickupTime)as BookingDate FROM TBooking
WHERE CONVERT(date, PickupTime) = '2015-05-04')as s1
ON TCab.CabID = s1.CabID
group by VendorID ;

--query 7 

SELECT BrandName, Name, TotalDistance, TravelledTime FROM (
SELECT BrandName,VendorID, TotalDistance, TravelledTime FROM ( 
SELECT CabID, SUM(Distance) as TotalDistance, 
SUM(Distance)/SUM(DateDiff(HH,PickupTime, DropTime )) AS TravelledTime 
FROM TBooking
GROUP BY CabID) as s1
JOIN TCab
ON s1.CabID = TCab.CabID)as s2
JOIN TVendor
ON s2.VendorID = TVendor.VendorID; 

