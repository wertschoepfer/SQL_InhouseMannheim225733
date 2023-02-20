-- "Rechnungen" erstellen; Bestellsumme = Quantity*UnitPrice + Freight - Discount evtl
-- Orders, Order Details

OrderID, Datum, Gesamtsumme

SELECT * FROM [Order Details]
SELECT * FROM 

SET STATISTICS TIME ON

SELECT CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight,
CAST(SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as decimal(10,2)) as SumOrder,
SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as SumOrder2
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight, Country


SELECT CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight,
CAST(SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as decimal(10,2)) as SumOrder,
SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as SumOrder2
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
--JOIN Products p ON p.ProductID = od.ProductID
GROUP BY CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight
HAVING CAST(SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as decimal(10,2))  > 1000

--HAVING nur wenn im WHERE nicht möglich!!

GO
CREATE VIEW vRechnungOrders
AS
SELECT CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight,
CAST(SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as decimal(10,2)) as SumOrder,
SUM(od.Quantity*od.Unitprice*(1-Discount)+Freight) as SumOrder2
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY CompanyName, c.CustomerID, o.OrderID, o.OrderDate, o.Freight, Country

DROP VIEW vRechnungOrders

ALTER VIEW vRechungsOrders

SELECT SumOrder FROM vRechnungOrders

SELECT * FROM sys.indexes


SELECT * INTO RechnungOrders FROM vRechnungOrders

SELECT * FROM RechnungOrders

