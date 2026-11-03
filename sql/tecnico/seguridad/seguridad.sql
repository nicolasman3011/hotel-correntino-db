-- =====================================================================
-- TÁCTICA DE SEGURIDAD - MÓDULO DE RESERVAS (HOTEL CORRENTINO)
-- Base de datos: hotelCorrentino (o tu base actual)
-- =====================================================================

USE hotelCorrentino; -- Asegúrate de estar en tu base de datos
GO

-- 1. CREAR USUARIOS DE BASE DE DATOS (Sin login, ideales para prácticas locales)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_recepcionista')
    CREATE USER usr_recepcionista WITHOUT LOGIN;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_sin_permisos')
    CREATE USER usr_sin_permisos WITHOUT LOGIN;
GO

-- 2. CREAR EL ROL PERSONALIZADO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_recepcionista' AND type = 'R')
    CREATE ROLE rol_recepcionista;
GO

-- 3. ASIGNAR PERMISOS AL ROL (Principio de mínimo privilegio)
-- El rol puede consultar catálogos y ejecutar el procedimiento oficial de reservas
GRANT SELECT ON OBJECT::dbo.Habitacion TO rol_recepcionista;
GRANT SELECT ON OBJECT::dbo.Huesped TO rol_recepcionista;
GRANT SELECT, INSERT, UPDATE ON OBJECT::dbo.Reserva TO rol_recepcionista;
GRANT SELECT, INSERT, UPDATE ON OBJECT::dbo.Detalle_Reserva TO rol_recepcionista;
GRANT EXECUTE ON OBJECT::dbo.RegistrarReservaHotel TO rol_recepcionista;

-- Bloquear explícitamente operaciones destructivas directas
DENY DELETE ON OBJECT::dbo.Habitacion TO rol_recepcionista;
DENY DELETE ON OBJECT::dbo.Reserva TO rol_recepcionista;
DENY DELETE ON OBJECT::dbo.Detalle_Reserva TO rol_recepcionista;
GO

-- 4. ASOCIAR EL USUARIO AUTORIZADO AL ROL
ALTER ROLE rol_recepcionista ADD MEMBER usr_recepcionista;
GO

-- =====================================================================
-- 5. SCRIPT DE DEMOSTRACIÓN (PRUEBAS CON EXECUTE AS USER)
-- =====================================================================

PRINT '-------------------------------------------------------------';
PRINT 'CASO 1: PRUEBA CON USUARIO AUTORIZADO (usr_recepcionista)';
PRINT '-------------------------------------------------------------';
EXECUTE AS USER = 'usr_recepcionista';
GO

-- 5.1 Prueba Concedida: Ejecutar el Procedimiento de Reserva que armaste
BEGIN TRY
    EXEC dbo.RegistrarReservaHotel 
        @id_reserva = 10, 
        @id_empleado = 4, 
        @id_huesped = 1, 
        @numero_habitacion = 104, 
        @fecha_ingreso = '2023-12-10', 
        @fecha_egreso = '2023-12-15';
    PRINT '-> ÉXITO [CONCEDIDO]: usr_recepcionista pudo registrar la reserva mediante el SP.';
END TRY
BEGIN CATCH
    PRINT '-> ERROR: ' + ERROR_MESSAGE();
END CATCH;
GO

-- 5.2 Prueba Denegada: Intentar eliminar una reserva directamente (Bloqueado por DENY)
BEGIN TRY
    DELETE FROM dbo.Reserva WHERE id_reserva = 10;
    PRINT '-> ALERTA: Se permitió la eliminación directa (No debería pasar).';
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Bloqueado por seguridad -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT; -- Volvemos al administrador
GO

PRINT '';
PRINT '-------------------------------------------------------------';
PRINT 'CASO 2: PRUEBA CON USUARIO NO AUTORIZADO (usr_sin_permisos)';
PRINT '-------------------------------------------------------------';
EXECUTE AS USER = 'usr_sin_permisos';
GO

-- 5.3 Prueba Denegada Total: Intentar ejecutar el procedimiento sin permisos
BEGIN TRY
    EXEC dbo.RegistrarReservaHotel 
        @id_reserva = 11, 
        @id_empleado = 4, 
        @id_huesped = 1, 
        @numero_habitacion = 104, 
        @fecha_ingreso = '2023-12-20', 
        @fecha_egreso = '2023-12-25';
    PRINT '-> ALERTA: Pudo ejecutar el procedimiento sin tener permisos.';
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Acceso denegado al procedimiento -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT; -- Volvemos al administrador original
GO
PRINT '-------------------------------------------------------------';
PRINT 'FIN DE LA DEMOSTRACIÓN DE SEGURIDAD - MÓDULO RESERVAS';
PRINT '-------------------------------------------------------------';
GO