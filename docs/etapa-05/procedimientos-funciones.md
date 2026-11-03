-- 1. FUNCIONES DEFINIDAS POR EL USUARIO

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

-- 2. PROCEDIMIENTOS ALMACENADOS

DROP PROCEDURE IF EXISTS dbo.RegistrarReservaHotel;
GO

CREATE PROCEDURE dbo.RegistrarReservaHotel
    @id_reserva INT,
    @id_empleado INT,
    @id_huesped INT,
    @numero_habitacion INT,
    @fecha_ingreso DATE,
    @fecha_egreso DATE
AS
BEGIN
    IF @fecha_egreso <= @fecha_ingreso
    BEGIN
        THROW 50001, 'Error: La fecha de egreso debe ser posterior a la fecha de ingreso.', 1;
    END

    IF EXISTS (
        SELECT 1 FROM Detalle_Reserva
        WHERE numero = @numero_habitacion
          AND (fecha_ingreso < @fecha_egreso AND fecha_egreso > @fecha_ingreso)
    )
    BEGIN
        THROW 50002, 'Error: La habitación seleccionada ya se encuentra reservada o ocupada en esas fechas.', 1;
    END

    -- Insertar en la tabla cabecera (Reserva)
    INSERT INTO Reserva (id_reserva, estado_reserva, fecha_hora_checkin, fecha_hora_checkout, id_empleado, id_huesped)
    VALUES (@id_reserva, 'confirmada', NULL, NULL, @id_empleado, @id_huesped);

    -- Insertar en la tabla detalle (Detalle_Reserva)
    INSERT INTO Detalle_Reserva (id_reserva, numero, fecha_ingreso, fecha_egreso, cantidad_habitaciones)
    VALUES (@id_reserva, @numero_habitacion, @fecha_ingreso, @fecha_egreso, 1);

    -- Actualizar el estado de la habitación
    UPDATE Habitacion
    SET estado_habitacion = 'reservada'
    WHERE numero = @numero_habitacion;
    
    PRINT 'Reserva registrada con éxito.';
END;
GO

-- 3. CODIGO PARA EVIDENCIAS

SELECT dbo.CalcularCostoEstadia('2023-12-01', '2023-12-06', 15000.00, 10.00) AS CostoTotalConDescuento;

EXEC dbo.RegistrarReservaHotel 
    @id_reserva = 4, 
    @id_empleado = 4, 
    @id_huesped = 1, 
    @numero_habitacion = 101, 
    @fecha_ingreso = '2023-12-01', 
    @fecha_egreso = '2023-12-10';

SELECT * FROM Reserva WHERE id_reserva = 4;
SELECT * FROM Detalle_Reserva WHERE id_reserva = 4;
SELECT * FROM Habitacion WHERE numero = 101; -- Debería decir 'reservada'

EXEC dbo.RegistrarReservaHotel 
    @id_reserva = 5, 
    @id_empleado = 5, 
    @id_huesped = 2, 
    @numero_habitacion = 101, 
    @fecha_ingreso = '2023-12-05', 
    @fecha_egreso = '2023-12-15';
