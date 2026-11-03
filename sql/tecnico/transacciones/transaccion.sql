-- =======================================================================
-- MANEJO DE TRANSACCIONES - REGISTRO DE RESERVA SEGURA
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
    SET NOCOUNT ON;

    -- Validaciones de reglas de negocio
    IF @fecha_egreso <= @fecha_ingreso
    BEGIN
        THROW 50001, 'Error: Fecha de egreso debe ser posterior a ingreso.', 1;
    END

    IF EXISTS (
        SELECT 1 FROM Detalle_Reserva
        WHERE numero = @numero_habitacion
          AND (fecha_ingreso < @fecha_egreso AND fecha_egreso > @fecha_ingreso)
    )
    BEGIN
        THROW 50002, 'Error: Habitación ocupada en esas fechas.', 1;
    END

    -- INICIO DEL BLOQUE TRANSACCIONAL (Propiedades ACID)
    BEGIN TRY
        BEGIN TRANSACTION; 

        -- 1. Cabecera de la reserva
        INSERT INTO Reserva (id_reserva, estado_reserva, fecha_hora_checkin, fecha_hora_checkout, id_empleado, id_huesped)
        VALUES (@id_reserva, 'confirmada', NULL, NULL, @id_empleado, @id_huesped);

        -- 2. Detalle de la reserva
        INSERT INTO Detalle_Reserva (id_reserva, numero, fecha_ingreso, fecha_egreso, cantidad_habitaciones)
        VALUES (@id_reserva, @numero_habitacion, @fecha_ingreso, @fecha_egreso, 1);

        -- 3. Actualización de disponibilidad
        UPDATE Habitacion
        SET estado_habitacion = 'reservada'
        WHERE numero = @numero_habitacion;
        
        -- Si llega hasta acá sin romper nada, guarda todo definitivo
        COMMIT TRANSACTION; 
        PRINT 'Reserva registrada con éxito (Transacción confirmada).';
    END TRY
    BEGIN CATCH
        -- Si falla cualquier INSERT o UPDATE, deshace todo
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; 
        
        PRINT 'Error detectado. Se ejecutó ROLLBACK: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
