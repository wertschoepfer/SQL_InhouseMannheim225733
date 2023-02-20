--CTEs - Common Table Expression


WITH cteName AS-- (CustomerID, CompanyName, City)

(
SELECT CustomerID, CompanyName, City FROM Customers
WHERE Country = 'Germany'
)

SELECT CompanyName, City FROM cteName


--CTE recursive

WITH cteRec (n, wochentag)
AS (
--Anchor
SELECT 0, DATENAME(weekday, 0) --Erster Durchlauf

UNION ALL

--recursion
SELECT n + 1, DATENAME(weekday, n+1) --X weitere Durchläufe
FROM cteRec 
WHERE n < 6
UNION ALL

SELECT n+2, DATENAME(weekday, n+2)
FROM cteRec 
--Terminator
WHERE n < 5
UNION ALL
SELECT n + 3, DATENAME(weekday, n+1) --X weitere Durchläufe
FROM cteRec 
WHERE n < 6
)
SELECT n,wochentag FROM cteRec

SET STATISTICS IO, TIME OFF
SELECT * FROM Customers
UNION -- Mit DISTINCT , UNION ALL ohne DISTINCT
SELECT * FROM Customers


CREATE TABLE Feiertage (
Mai1 date,
DtEinheit date,
Weihnachten date)

INSERT INTO Feiertage
VALUES ('20200501', '20201003', '20201224'),
('20210501', '20211003', '20211224'),
('20220501', '20221003', '20221224')

ALTER TABLE Feiertage
ADD Jahr varchar(4)

UPDATE Feiertage SET Jahr = 2022
WHERE Mai1 = '20220501'

SELECT * FROM Feiertage



CREATE PROCEDURE

WITH ctePivot AS
(
SELECT '1' as jr, Jahr, Mai1 AS VALUE FROM Feiertage
UNION ALL
SELECT '2' as jr, Jahr, DtEinheit AS VALUE FROM Feiertage
UNION ALL
SELECT '3' as jr, Jahr, Weihnachten AS VALUE FROM Feiertage
)
SELECT [2020], [2021], [2022]
FROM (SELECT * FROM ctePivot) as piv

PIVOT (MAX(VALUE) For Jahr
IN ([2020], [2021], [2022]) ) as piv2



