SELECT
OrderID, Freight,
CASE
	WHEN Freight < 50 THEN 'DHL'
	WHEN Freight > 200 THEN 'Shipping'
	ELSE 'Cargo'
END as Delivery, OrderDate
FROM Orders

SELECT
CustomerID, OrderID, Freight,
CASE
	WHEN CustomerID IN (SELECT CustomerID FROM Customers WHERE Country = 'germany')
	THEN 'DHL'
	WHEN Freight > 200 THEN 'Shipping'
	ELSE 'Cargo'
END as Delivery, OrderDate
FROM Orders

UPDATE Customers
SET ContactName = CASE
	WHEN Country = 'Germany' THEN 'Hans Mueller'
	WHEN Country = 'France' THEN 'Jaque Gusto' END

-- CASE = SELECT/UPDATE/DELETE Fallunterscheidung

-- IF = Code "Flow"


IF @@TRANCOUNT = 1
BEGIN PRINT 'Du bist schon in TRAN' END
ELSE
BEGIN TRAN



DECLARE @Count int = 1
WHILE @Count <= 10
BEGIN
SET @Count += 1
IF @Count % 2 = 0 BEGIN SELECT @Count, 'Durch 2 Teilbar'END
END


DECLARE @Count int = 1
WHILE @Count <= 10
BEGIN
SET @Count += 1
IF @Count  = 5 BEGIN GOTO Anfang END
END
Anfang:
SELECT 'Fertig', @Count