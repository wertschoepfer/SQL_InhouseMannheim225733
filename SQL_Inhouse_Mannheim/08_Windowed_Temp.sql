-- #temp
-- # = temptable "lokal"; ## = global
/*
SELECT * INTO #test FROM Customers
WHERE Country = 'Germany'

SELECT * FROM #test

SELECT * INTO ##test FROM Customers
WHERE Country = 'Germany'

DROP TABLE ##test
*/
USE Northwind
GO
DROP TABLE IF EXISTS #t
GO
SELECT 
ROW_NUMBER() OVER(Order by CustomerID) as ID,
* 
INTO #t FROM Customers

DECLARE @Count int = 1
WHILE @Count <= (SELECT COUNT(*) FROM #t)
BEGIN
SELECT * FROM #t WHERE id = @Count
SET @Count += 1
END

SET STATISTICS TIME, IO OFF



SELECT c.CustomerID, CompanyName, o.OrderID,
SUM(od.Quantity*od.Unitprice) OVER (PARTITION BY o.Orderid, ProductID) as PosiSum,
SUM(od.Quantity*od.Unitprice) OVER (ORDER BY c.CustomerID, o.OrderID, ProductId) as RunningTotal,
SUM(od.Quantity*od.Unitprice) OVER (PARTITION BY o.OrderID) as OrderSum,
SUM(od.Quantity*od.Unitprice) OVER (PARTITION BY c.CustomerID) as CustomerIDSum,
SUM(od.Quantity*od.Unitprice) OVER (PARTITION BY 1) as GesamtUmsatz
--AVG(od.Quantity*od.Unitprice) OVER (Order BY c.CustomerID)
FROM Customers c
jOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.ORderiD = o.OrderID
ORDER BY c.CustomerID

SELECT c.CustomerID, CompanyName, o.OrderID,
SUM(od.Quantity*od.Unitprice) OVER (ORDER BY o.OrderID RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM Customers c
jOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.ORderiD = o.OrderID
ORDER BY c.CustomerID


