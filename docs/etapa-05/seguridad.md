# Investigación e Implementación: Seguridad (Tema 4)

## 1. Conceptos Teóricos
- **Principio de Mínimo Privilegio**: Asignar a cada usuario únicamente los permisos indispensables para su rol operativo, evitando riesgos de manipulación de datos sensibles.
- **Roles y Usuarios sin Login**: Creación de roles personalizados (`rol_recepcionista`) para agrupar permisos y asignación a usuarios locales sin acceso al motor (`WITHOUT LOGIN`).
- **Control Granular (`GRANT` / `DENY`)**: Permite conceder lecturas y ejecuciones explícitas mientras se bloquean de forma estricta operaciones destructivas (`DELETE`).

---

## 2. Implementación T-SQL (Seguridad y Pruebas)

```sql
USE hotelCorrentino;
GO

-- 1. Usuarios de prueba (Sin Login)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_recepcionista')
    CREATE USER usr_recepcionista WITHOUT LOGIN;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usr_sin_permisos')
    CREATE USER usr_sin_permisos WITHOUT LOGIN;
GO

-- 2. Rol Personalizado
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_recepcionista' AND type = 'R')
    CREATE ROLE rol_recepcionista;
GO

-- 3. Permisos Granulares (Mínimo Privilegio)
GRANT SELECT ON OBJECT::dbo.Habitacion TO rol_recepcionista;
GRANT SELECT ON OBJECT::dbo.Huesped TO rol_recepcionista;
GRANT SELECT, INSERT, UPDATE ON OBJECT::dbo.Reserva TO rol_recepcionista;
GRANT SELECT, INSERT, UPDATE ON OBJECT::dbo.Detalle_Reserva TO rol_recepcionista;
GRANT EXECUTE ON OBJECT::dbo.RegistrarReservaHotel TO rol_recepcionista;

-- Bloqueo explícito de eliminaciones
DENY DELETE ON OBJECT::dbo.Habitacion TO rol_recepcionista;
DENY DELETE ON OBJECT::dbo.Reserva TO rol_recepcionista;
DENY DELETE ON OBJECT::dbo.Detalle_Reserva TO rol_recepcionista;
GO

-- 4. Asignación del usuario al rol
ALTER ROLE rol_recepcionista ADD MEMBER usr_recepcionista;
GO

-- 5. Demostración de Pruebas (EXECUTE AS USER)
PRINT '--- CASO 1: USUARIO AUTORIZADO (usr_recepcionista) ---';
EXECUTE AS USER = 'usr_recepcionista';
GO

BEGIN TRY
    EXEC dbo.RegistrarReservaHotel 
        @id_reserva = 10, @id_empleado = 4, @id_huesped = 1, 
        @numero_habitacion = 104, @fecha_ingreso = '2023-12-10', @fecha_egreso = '2023-12-15';
    PRINT '-> ÉXITO [CONCEDIDO]: Reserva registrada correctamente.';
END TRY
BEGIN CATCH
    PRINT '-> ERROR: ' + ERROR_MESSAGE();
END CATCH;
GO

BEGIN TRY
    DELETE FROM dbo.Reserva WHERE id_reserva = 10;
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Bloqueado por DENY -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT;
GO

PRINT '--- CASO 2: USUARIO NO AUTORIZADO (usr_sin_permisos) ---';
EXECUTE AS USER = 'usr_sin_permisos';
GO

BEGIN TRY
    EXEC dbo.RegistrarReservaHotel 
        @id_reserva = 11, @id_empleado = 4, @id_huesped = 1, 
        @numero_habitacion = 104, @fecha_ingreso = '2023-12-20', @fecha_egreso = '2023-12-25';
END TRY
BEGIN CATCH
    PRINT '-> RESULTADO CORRECTO [DENEGADO]: Acceso denegado -> ' + ERROR_MESSAGE();
END CATCH;
GO

REVERT;
GO