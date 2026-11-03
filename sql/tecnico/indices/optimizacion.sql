-- =======================================================================
-- OPTIMIZACIÓN DE CONSULTAS A TRAVÉS DE ÍNDICES (HOTEL CORRENTINO)
-- =======================================================================

-- Parte 1: Creación de la tabla de pruebas (PagoHistorico)
CREATE TABLE PagoHistorico (
    id_pago BIGINT IDENTITY(1,1),
    fecha_pago DATE NOT NULL,
    importe DECIMAL(12,2) NOT NULL
);
GO

-- Parte 2: Carga masiva de datos (1.000.000 de registros)
SET NOCOUNT ON;
GO

WITH Numeros AS (
    SELECT TOP (1000000) ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a CROSS JOIN sys.objects b CROSS JOIN sys.objects c
)
INSERT INTO PagoHistorico(fecha_pago, importe)
SELECT
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1825, '2020-01-01'),
    RAND(CHECKSUM(NEWID())) * 10000
FROM Numeros;
GO

-- Parte 3: Activación de estadísticas de rendimiento
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- Prueba 1: Consulta SIN índices (Genera un Table Scan lento)
PRINT '--- CONSULTA SIN ÍNDICES ---';
SELECT id_pago, fecha_pago, importe
FROM PagoHistorico
WHERE fecha_pago BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- Parte 4: Crear índice agrupado sobre la fecha
CREATE CLUSTERED INDEX IX_PagoHistorico_Fecha
ON PagoHistorico (fecha_pago);
GO

-- Prueba 2: Consulta CON índice agrupado (Genera un Clustered Index Seek más rápido)
PRINT '--- CONSULTA CON ÍNDICE AGRUPADO ---';
SELECT id_pago, fecha_pago, importe
FROM PagoHistorico
WHERE fecha_pago BETWEEN '2023-01-01' AND '2023-03-31';
GO

-- Parte 5: Crear índice con cobertura (incluyendo el importe)
CREATE NONCLUSTERED INDEX IX_PagoHistorico_Fecha_Cobertura
ON PagoHistorico (fecha_pago)
INCLUDE (importe);
GO

-- Prueba 3: Consulta CON índice de cobertura (Resolución óptima solo leyendo el índice)
PRINT '--- CONSULTA CON ÍNDICE DE COBERTURA ---';
SELECT fecha_pago, importe
FROM PagoHistorico
WHERE fecha_pago BETWEEN '2023-01-01' AND '2023-03-31';
GO
