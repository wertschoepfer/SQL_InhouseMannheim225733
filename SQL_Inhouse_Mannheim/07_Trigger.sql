--TRIGGER

ALTER TRIGGER tr_Demo2 ON [Order Details] 
FOR UPDATE
AS


UPDATE RechnungOrders
SET LastUpdated = (SELECT getdate())
WHERE OrderID IN(
SELECT DISTINCT OrderID FROM inserted
WHERE OrderID IN(
SELECT * FROM inserted
EXCEPT
SELECT * FROM deleted
)
)


BEGIN TRAN
UPDATE Customers SET City = 'Berlin'
WHERE CustomerID = 'PARIS'

SELECT * FROM inserted

ROLLBACK


SELECT * FROM RechnungOrders
WHERE OrderID = 10248

ALTER TABLE RechnungOrders
ADD  LastUpdated datetime

UPDATE [Order Details]
SET Discount = 0.15
WHERE ProductID LIKE '%'

SELECT * FROM [Order Details]

UPDATE RechnungOrders
SET SumOrder = 
(CAST(SUM(od.@Quantity*od.Unitprice*(1-Discount)+Freight) as decimal(10,2))
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID)

WHERE OrderID = @OrderID



