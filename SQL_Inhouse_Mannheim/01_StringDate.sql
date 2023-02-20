SELECT * FROM sys.tables
SELECT * FROM sys.columns
SELECT * FROM sys.databases

-- COLUMN Ordner Drag & Drop in Abfrage
-- Oder einzelne Spalten

-- STRING Functions:

--LEFT/RIGHT Stringparts
SELECT LEFT(CompanyName, 5) FROM Customers
SELECT RIGHT(CompanyName, 5) FROM Customers

--Stringparts
SELECT CustomerID, SUBSTRING(CustomerID, 2, 3) as CustomString FROM Customers

--Whitespace removal
SELECT LTRIM(), RTRIM(), TRIM()
-- "löscht" Leerzeichen links/rechts vom String
INSERT INTO Customers (CustomerID, CompanyName)
VALUES ('PPEDV','       PPEDV AG          ')

SELECT * FROM Customers
WHERE CustomerID = 'PPEDV'

SELECT LTRIM(CompanyName) FROM Customers
WHERE CustomerID = 'PPEDV'

--Länge des Strings
SELECT LEN(CompanyName) FROM Customers
WHERE CustomerID = 'PPEDV'

--Stringpart entfernen und ersetzen
SELECT STUFF(Phone, 5, 10, 'XXXX') FROM Customers

--Telefonnummer, nur die letzten 4 Symbole sichtbar, alles davor 'XXX'

SELECT STUFF(Phone, 1, LEN(Phone) - 4, REPLICATE('X', LEN(Phone) - 4)) FROM Customers

--Definierten Char ersetzen
SELECT CustomerID, REPLACE(CustomerID, 'N', 'X') FROM Customers

--Position Char in String
SELECT CHARINDEX('N', CustomerID) FROM Customers
SELECT CHARINDEX('N', CustomerID, 3) FROM Customers

--String umdrehen
SELECT REVERSE(CustomerID) FROM Customers

--Position eines "Patterns" in String
SELECT CustomerID, PATINDEX('%LF%', CustomerID) FROM Customers

SELECT ADDress FROM Customers

--PATINDEX('%[0-9]%', Address) as Stra
SELECT
LEFT(Address, LEN(Address) - (LEN(Address) - PATINDEX('%[0-9]%', Address) + 1))
FROM Customers

SELECT LEN(Address), Address, PATINDEX('%[0-9]%', Address) FROM Customers

--String konkatieren
SELECT CONCAT(Firstname, ' ', Lastname) FROM Employees
SELECT Firstname + ' ' + Lastname FROM Employees

SELECT CompanyName, SOUNDEX(CompanyName) FROM Customers
--Difference rankt von 0 - 4 (=match) wie ähnlich die Strings sind
SELECT DIFFERENCE('Nett', 'mett')

SELECT CustomerID, DIFFERENCE(CustomerID, 'EDV')FROM Customers


/*************************************************************************/


--DATE Functions

--Systemzeit Server
SELECT getdate()

--Interval addieren/subtrahieren 
SELECT DATEADD(dd, 10, getdate())

--Datentyp konvertieren
SELECT CAST(DATEADD(dd, 10, getdate()) as date)

--Datentyp konvertieren
SELECT CONVERT(varchar(20), DATEADD(dd, 10, getdate()), 104)

--Differenz zwischen Datums
SELECT DATEDIFF(week, '19940101', getdate())

--Teile eines Datums ausgeben
SELECT OrderDate, YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate) FROM Orders
SELECT DATEPART(Quarter, Orderdate) FROM Orders

--Datename 
SELECT DATENAME(WEEKDAY, Orderdate) FROM Orders
SELECT DATENAME(MONTH, Orderdate) FROM Orders
SELECT DATENAME(DAYOFYEAR, Orderdate) FROM Orders

SELECT * FROM Orders
--Alle OrderID deren ShippedDate > RequiredDate in Tagen Differenz
SELECT DATEDIFF(dd, RequiredDate, ShippedDate) as Verzögerung FROM Orders
WHERE DATEDIFF(dd, RequiredDate, ShippedDate) > 0
ORDER BY Verzögerung DESC

SELECT DATEDIFF(dd, RequiredDate, ISNULL(ShippedDate, getdate())) as Verzögerung FROM Orders
WHERE DATEDIFF(dd, RequiredDate, ISNULL(ShippedDate, getdate())) > 0
ORDER BY Verzögerung DESC

SELECT DATEDIFF(dd, RequiredDate, ISNULL(ShippedDate, getdate())) as Verzögerung FROM Orders
WHERE Verzögerung> 0
ORDER BY Verzögerung DESC


