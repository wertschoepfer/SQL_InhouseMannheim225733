--Table Partitionierung

CREATE TABLE Sales (
ID int identity,
SaleDate datetime,
Revenue decimal(10,2)
)

INSERT INTO Sales
SELECT 
CAST(CAST(RAND()*1000 + 45000 as int) as datetime) as SaleDate,
CAST(RAND()*50 + 5 as decimal(10,2)) as Revenue
GO 100000

SELECT MIN(SaleDate), MAX(SaleDATE) FROM Sales

-- Range 17.03.2023 bis 10.12.2025

-- 1. Filegroups & Files erstellen

-- 2. Partitionsfunktion schreiben

INSERT INTO Sales
VALUES ('20220830', 15),
('20260501', 22)


CREATE PARTITION FUNCTION SalesPerYearFunction (datetime)
AS 
RANGE RIGHT FOR VALUES ('20240101', '20250101', '20260101')
--RANGE LEFT FOR VALUES ('20221231', '20240101', '20250101')

CREATE PARTITION SCHEME SalesPerYearSchema
AS PARTITION SalesPerYearFunction
TO (Sales2023, Sales2024, Sales2025, [PRIMARY])


CREATE CLUSTERED INDEX cix_SalesPerYear ON Sales
(SaleDate) ON SalesPerYearSchema(SaleDate)

SELECT * FROM Sys.partitions
SELECT * FROM sys.filegroups

SELECT p.partition_number as partition_number,
f.name,
p.rows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(Object_ID) = 'sales'



CREATE TABLE Sales2 (
ID int identity,
SaleDate datetime,
Revenue decimal(10,2)
)

INSERT INTO Sales2
SELECT 
CAST(CAST(RAND()*1000 + 45000 as int) as datetime) as SaleDate,
CAST(RAND()*50 + 5 as decimal(10,2)) as Revenue
GO 100000


SET STATISTICS TIME, IO ON

SELECT * FROM Sales WHERE YEAR(SaleDate) = 2024
--, CPU-Zeit = 47 ms, verstrichene Zeit = 274 ms.; Sales". Anzahl von Überprüfungen: 4, logische Lesevorgänge: 480,
SELECT * FROM Sales2 WHERE YEAR(SaleDate) = 2024
--, CPU-Zeit = 78 ms, verstrichene Zeit = 263 ms.; logische Lesevorgänge: 390,
--Ohne CIX


SELECT * FROM Sales WHERE SaleDate BETWEEN '20240801' AND '20240915'

SELECT * FROM Sales2 WHERE SaleDate BETWEEN '20240801' AND '20240915'

CREATE CLUSTERED INDEX cix_sales2SaleDate ON Sales2 (SaleDate) 

SELECT * FROM Sales2 WHERE SaleDate = '20240101'

SELECT * FROM Sales WHERE SaleDate = '20240101'

SELECT SUM(Revenue) FROM Sales WHERE Year(SaleDate) = 2024

SELECT SUM(Revenue) FROM Sales2 WHERE Year(SaleDate) = 2024


dbcc showcontig('customers')


CREATE TABLE PageShit (
id int identity,
zeugs varchar(max),
andereszeugs varchar(max))

INSERT INTO PageShit
SELECT 'abCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', 'ACVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
GO 100

dbcc showcontig('PageShit')

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(8), 0, -1, 0, 'DETAILED')

SELECT * FROM sys.databases
SELECT * FROM sys.indexes


/* Rules of thumb für indexing

- Unique Spalten = clustered index
- Foreign Keys, bzw. frequently joined Spalten = NCIX
- weniger ist mehr bei Tables die viel geschrieben werden
*/

CREATE NON CLUSTERED INDEX blabla ON table (col1, col2) 