--Functions

CREATE FUNCTION f_NettoToBrutto (@Wert decimal(10,2))
RETURNS decimal(10,2)
BEGIN
	SET @Wert = @Wert*1.19
	RETURN @wert
END

SELECT dbo.f_nettotoBrutto (401)

CREATE FUNCTION f_NettoToBrutto (@Wert decimal(10,2))
RETURNS decimal(10,2)
BEGIN
	SET @Wert = @Wert*1.19
	RETURN @wert
END


ALTER PROCEDURE sp_OutputDemo @Input int, @ReturnValue bit = 0 OUTPUT 
AS
SET @ReturnValue = 1
RETURN @ReturnValue

DECLARE @ReturnValue bit
EXEC @ReturnValue = dbo.sp_OutputDemo
	@Input = 1
SELECT @ReturnValue

EXEC sp_OutputDemo 1


/*************************************************************/

--Dynamic SQL

ALTER PROCEDURE sp_Dynamic  @Spalte varchar(20)
AS
DECLARE @sql varchar(500)
SET @sql = 'SELECT [' + @Spalte  + '] FROM Customers'
EXEC (@sql)

SELECT * FROM [Order Details]

EXEC sp_Dynamic City


--Function input OrderID; Returns CompanyName