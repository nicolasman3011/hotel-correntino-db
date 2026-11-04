-- =======================================================================
-- PROCEDIMIENTOS ALMACENADOS - HOTEL CORRENTINO
-- =======================================================================

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
    -- [MODIFICACIÓN]: Se mantienen las validaciones de negocio básicas por separado, 
    -- dejando la lógica de control transaccional robusta (ACID) para el módulo de transacciones.
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
        THROW 50002, 'Error: La habitación seleccionada ya se encuentra reservada u ocupada en esas fechas.', 1;
    END

    INSERT INTO Reserva (id_reserva, estado_reserva, fecha_hora_checkin, fecha_hora_checkout, id_empleado, id_huesped)
    VALUES (@id_reserva, 'confirmada', NULL, NULL, @id_empleado, @id_huesped);

    INSERT INTO Detalle_Reserva (id_reserva, numero, fecha_ingreso, fecha_egreso, cantidad_habitaciones)
    VALUES (@id_reserva, @numero_habitacion, @fecha_ingreso, @fecha_egreso, 1);

    UPDATE Habitacion
    SET estado_habitacion = 'reservada'
    WHERE numero = @numero_habitacion;
    
    PRINT 'Reserva registrada con éxito.';
END;
GO
-- PRUEBA DEL PROCEDIMIENTO - Caso exitoso
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

-- PRUEBA DEL PROCEDIMIENTO - Caso falldio
EXEC dbo.RegistrarReservaHotel 
    @id_reserva = 5, 
    @id_empleado = 5, 
    @id_huesped = 2, 
    @numero_habitacion = 101, 
    @fecha_ingreso = '2023-12-05', 
    @fecha_egreso = '2023-12-15';
