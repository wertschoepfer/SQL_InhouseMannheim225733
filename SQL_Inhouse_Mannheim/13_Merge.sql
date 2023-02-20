SELECT RAND()*100+5

CREATE TABLE ProduktAlt (
id int identity,
PName varchar(20),
Price int)

CREATE TABLE ProduktNeu (
id int identity,
PName varchar(20),
Price int)

INSERT INTO ProduktAlt
VALUES ('Tisch', 100),
('Stuhl', 50),
('Schrank', 200),
('Lampe', 10)

INSERT INTO ProduktNeu
VALUES ('Tisch', 120),
('Stuhl', 50),
('Schrank', 180),
('Teppich', 70)

SELECT * FROM ProduktAlt
SELECT * FROM ProduktNeu


--MERGE

MERGE ProduktAlt TARGET
USING ProduktNeu SOURCE
ON TARGET.PName = SOURCE.PName

WHEN NOT MATCHED BY TARGET THEN
INSERT 
VALUES (SOURCE.PName, SOURCE.Price)

WHEN MATCHED THEN UPDATE SET
	TARGET.Price = SOURCE.Price

WHEN NOT MATCHED BY SOURCE THEN DELETE;

