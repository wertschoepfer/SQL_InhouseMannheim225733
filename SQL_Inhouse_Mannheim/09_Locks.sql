ALTER PROCEDURE sp_Left AS
BEGIN TRAN

UPDATE Customers
SET City = 'Berlin'
WAITFOR DELAY '00:00:05'
UPDATE Suppliers
SET City = 'Wien'

WAITFOR DELAY '00:00:05'

ROLLBACK

EXEC sp_Left

ALTER PROCEDURE sp_Right AS
BEGIN TRAN

UPDATE Customers
SET City = 'Berlin'
WAITFOR DELAY '00:00:05'
UPDATE Suppliers
SET City = 'Wien'

WAITFOR DELAY '00:00:05'

ROLLBACK

EXEC sp_Right




CREATE TABLE TestLock
(ID int identity,
abc varchar(10))

INSERT INTO Testlock
VALUES ('ABC')
GO 10000

BEGIN TRAN
UPDATE Testlock 
SET abc = 'xyz'
WHERE ID BETWEEN 1 AND 6000
ROLLBACK



INSERT INTO Testlock
VALUES ('xyz')
GO 10

CREATE PROC TestlockLookup @zeug varchar(10)
AS
SELECT * FROM Testlock
WHERE abc = @zeug

EXEC TestlockLookup abc