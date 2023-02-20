SELECT c.CustomerID, o.Freight FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID

-- CROSS JOIN Table1 x Table2:
SELECT * FROM Customers
CROSS JOIN Orders

--INNER JOIN 

SELECT DISTINCT c.CustomerID FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID

--OUTER JOIN 

SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
--WHERE OrderID IS NULL

--FULL OUTER JOIN
SELECT c.CustomerID, o.Orderid 
FROM Customers c FULL JOIN Orders o ON c.CustomerID = o.CustomerID

--Left & Right Join: Merke "links" bzw. "rechts" des Join Keywords
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID

SELECT [EmployeeID],[LastName],[ReportsTo]FROM Employees

--Ergebnistabelle Employees, Name Mitarbeiter + Name des Vorgesetzten in selber Zeile

--Self Join
SELECT e1.FirstName + ' ' + e1.Lastname as Mitarbeiter, 
e2.Firstname + ' ' + e2.Lastname as Vorgesetzter FROM Employees e1
LEFT JOIN Employees e2 ON e2.EmployeeID = e1.ReportsTo



