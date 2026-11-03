-- =======================================================================
-- 1. FUNCIONES DEFINIDAS POR EL USUARIO
-- =======================================================================

DROP FUNCTION IF EXISTS dbo.CalcularCostoEstadia;
GO

CREATE FUNCTION dbo.CalcularCostoEstadia 
(
    @FechaIngreso DATE, 
    @FechaEgreso DATE, 
    @PrecioNoche DECIMAL(10,2),
    @PorcentajeDescuento DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Dias INT = DATEDIFF(DAY, @FechaIngreso, @FechaEgreso);
    
    IF @Dias = 0 SET @Dias = 1; 

    DECLARE @CostoBruto DECIMAL(10,2) = @Dias * @PrecioNoche;
    DECLARE @Descuento DECIMAL(10,2) = @CostoBruto * (@PorcentajeDescuento / 100.0);
    
    RETURN @CostoBruto - @Descuento;
END;
GO

-- PRUEBA DE LA FUNCIÓN:
SELECT dbo.CalcularCostoEstadia('2023-12-01', '2023-12-06', 15000.00, 10.00) AS CostoTotalConDescuento;
