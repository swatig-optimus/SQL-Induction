/*CREATING DATABASE*/
CREATE DATABASE Db_02;

/*CREATING PRODUCT TABLE*/
	CREATE TABLE t_product_master (
	Product_ID VARCHAR(20)PRIMARY KEY,
	Product_Name VARCHAR(50),
	Cost_Per_Item INT
)
--cost per item is in rupees

/*CREATING USER TABLE*/
CREATE TABLE t_user_master (
	UserId VARCHAR(20) PRIMARY KEY,
	UserName VARCHAR(50),
)

/*CREATING TRANSACTION TABLE*/
CREATE TABLE t_transaction (
	UserId VARCHAR(20),
	Product_ID VARCHAR(20),
	Transaction_Date DATE,
	Transaction_Type VARCHAR(20),
	Transaction_Amount INT
)
/*ADDING FOREIGN KEYS TO TRANSACTION TABLE*/
ALTER TABLE t_transaction
ADD CONSTRAINT fk_product
FOREIGN KEY (Product_ID)
REFERENCES t_product_master(Product_ID)

ALTER TABLE t_transaction
ADD CONSTRAINT fk_user
FOREIGN KEY (UserId)
REFERENCES t_user_master(UserId)

/*INSERT VALUES INTO PRODUCT TABLE */
INSERT INTO t_product_master
VALUES('P1','Pen',10);
INSERT INTO t_product_master
VALUES('P2','Scale',15);
INSERT INTO t_product_master
VALUES('P3','Notebook',25);

SELECT * FROM t_product_master;

/*INSERT VALUES INTO USER TABLE */
INSERT INTO t_user_master
VALUES('U1','Alfred Lawrence');
INSERT INTO t_user_master
VALUES('U2','William Paul');
INSERT INTO t_user_master
VALUES('U3','Edward Fillip');

SELECT * FROM t_user_master;

/*INSERT VALUES INTO TRANSACTION TABLE */
INSERT INTO t_transaction
VALUES('U1','P1','2010-10-25','Order',150);
INSERT INTO t_transaction
VALUES('U1','P1','2010-11-20','Payment',750);
INSERT INTO t_transaction
VALUES('U1','P1','2010-11-20','Order',200);
INSERT INTO t_transaction
VALUES('U1','P3','2010-11-25','Order',50);
INSERT INTO t_transaction
VALUES('U3','P2','2010-11-26','Order',100);
INSERT INTO t_transaction
VALUES('U2','P1','2010-12-15','Order',75);
INSERT INTO t_transaction
VALUES('U3','P2','2011-01-15','Payment',250);
SELECT * FROM t_transaction;
--Orders are in quantity and Payments are in Rupees.

/*QUERIES*/
SELECT  u.UserName, p.Product_Name, 
SUM(
CASE 
when t.Transaction_Type='Order'
then Transaction_Amount 
END 
 )AS Ordered_Quantity,
 
sum(
CASE
when t.Transaction_Type='Payment'
then Transaction_Amount
END
)AS Amount_paid,

max(convert(varchar(20),t.Transaction_Date,105))
AS Last_Transaction_Date,

SUM(
case 
when t.Transaction_Type='order' 
then  Transaction_Amount * p.Cost_Per_Item
else -Transaction_Amount
end
) as Balance

FROM t_product_master AS p, t_user_master AS u, t_transaction AS t

WHERE p.Product_ID=t.Product_ID AND u.UserId=t.UserId
GROUP BY u.UserName, p.Product_Name;