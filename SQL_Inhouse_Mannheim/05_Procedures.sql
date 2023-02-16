--Procedures; 

CREATE PROCEDURE sp_Demo @Country varchar(20)
AS
SELECT * FROM Customers
WHERE Country = @Country
--Diese Procedure macht dies und das
EXEC sp_Demo Spain

DROP PROCEDURE sp_Demo

ALTER PROCEDURE 

ALTER PROCEDURE sp_Demo @Country varchar(20) = NULL
AS
SELECT * FROM Customers
WHERE Country = ISNULL(@Country, Country)

EXEC Umsatz 2022 WITH RECOMPILE


EXEC sp_demo Germany

SELECT CompanyName
FROM
(EXEC sp_demo Germany) t

--Variablen
DECLARE @var1 int = 1, @var2 float, @var3 int

SELECT @var1
SET @Var1 = (SELECT 5)
SELECT @Var1

--WHILE loops
DECLARE @var1 int = 0

WHILE @var1 <= 5
BEGIN
SELECT @var1
SET @var1 += 1
END


CREATE PROCEDURE sp_Demo @Country varchar(20), @City varchar(20)
AS
SELECT * FROM Customers
WHERE Country = @Country

--Procedure erstellen, die Freight (Orders) in 10% Schritten erhöht
--AVG(Freight) darf dabei 150 nicht überschreiten
DECLARE @Tablename varchar(50), @Sql varchar(255)
SET @Tablename = 'TestTable'
SET @Sql = 'SELECT * INTO [' + @Tablename + '] FROM Orders'
EXEC (@Sql)

SELECT * INTO #TempTable FROM Customers

DECLARE @TableVar TABLE (Company varchar(50), City varchar(20))
INSERT INTO @TableVar SELECT CompanyName, City FROM Customers

SELECT * FROM @TableVar

ALTER PROC sp_FreightInc @Percent decimal(5,2)
AS
WHILE (SELECT AVG(Freight)*@Percent FROM BackupOrders) < 150
BEGIN
UPDATE BackupOrders SET Freight = Freight*@Percent
END

EXEC Sp_FreightInc 1.1

DROP TABLE BackupOrders
SELECT * INTO BackupOrders FROM Orders

SELECT AVG(Freight) FROM BackupOrders