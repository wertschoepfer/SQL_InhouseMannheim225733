CREATE TABLE DateTest 
(ID int identity,
Zeugs datetime)

INSERT INTO DateTest 
VALUES (getdate())
GO 50000

SELECT DISTINCT Zeugs FROM DateTest

DROP TABLE #t

--Ranking Functions, LAG/LEAD/RANK/NTILE

SELECT Zeugs, LAG(Zeugs, 1) OVER(ORDER BY Zeugs) as x,
CAST(Zeugs - LAG(Zeugs, 1) OVER(ORDER BY Zeugs) as float) as Diff
INTO #t 
FROM DateTest

SELECT Zeugs, LAG(Zeugs, 1) OVER(ORDER BY Zeugs) as x
FROM DateTest

SELECT AVG(Diff) FROM #t


SELECT *, DENSE_RANK() OVER (ORDER BY Zeugs) FROM Ranktest

SELECT *, RANK() OVER (ORDER BY Zeugs) FROM Ranktest

SELECT *, NTILE(5) OVER (ORDER BY ID) FROM Ranktest

INSERT INTO Ranktest
VALUES ('D')