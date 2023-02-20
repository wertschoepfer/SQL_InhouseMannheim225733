--Aggregat Functions

SELECT MIN(Freight), MAX(Freight), COUNT(Freight), AVG(Freight), SUM(Freight) FROM Orders

SELECT OrderID, SUM(Freight) FROM Orders

--Sobald nicht-Aggregat Spalten im SELECT: GROUP BY
SELECT CustomerID, OrderDate, 
SUM(Freight), 
SUM(Freight) * 100/ (SELECT SUM(Freight) FROM Orders) as Prozent
FROM Orders
GROUP BY CustomerID, OrderDate
ORDER BY Prozent DESC

--"CopyPaste" alles aus dem SELECT ins GROUP BY, dass kein AGGREGATE ist

SELECT o.CustomerID, CompanyName, Address, City, SUM(Freight) as SummeFracht FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY o.CustomerID, CompanyName, Address, City


--Sinnhaftigkeit der Groups bzw. der angezeigten Spalten im Select hinterfragen!
--Nur identische Datensätze können gruppiert werden
