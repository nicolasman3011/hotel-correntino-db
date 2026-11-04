1_Definición y Objetivo
-Un trigger (o desencadenador) es un objeto programable dentro del motor de base de datos que se ejecuta automáticamente de forma transparente en respuesta a un evento DML específico (INSERt, UPDATE o DELETE) sobre una tabla o vista.
-Busca garantizar la trazabilidad e integridad del sistema mediante el registro automático de los cambios de las tarifas en las habitaciones. Busca responder de forma auditable a qué valor tenía una habitación antes de ser modificada, cuál es su nuevo precio, qué usuario realizó el cambio y cuándo sucedió.

2_Ventajas y Aplicaciones
--Ventajas:
1_Ejecución Automática en Segundo Plano: Al activarse automáticamente a nivel de motor, no depende de la lógica de la aplicación cliente ni corre el riesgo de ser omitido por un operador[2].
2_Acceso a Estados Transaccionales: Permite comparar simultáneamente el estado previo (deleted) y el posterior (inserted) de una fila durante la misma transacción.
3_Auditoría Selectiva: Mediante IF UPDATE(precio), evita consumos de recursos innecesarios al actuar únicamente cuando la columna crítica sufre una variación real.
4_Optimización con SET NOCOUNT ON: Evita la transmisión de mensajes de recuento de filas a través de la red, mejorando la eficiencia general de la transacción.

--Aplicaciones
1_Control de tarifas y auditoría financiera: Detección de modificaciones erróneas o no autorizadas en el precio de una habitación.
2_Seguridad y responsabilidad: Registro explícito del usuario (SYSTEM_USER) para desginar las responsabilidades operativas en recepción o administración.

3_Implementación en SQL Server Express
El trigger aprovecha las tablas temporales en memoria creadas por SQL durante la transacción:

-deleted(d): Almacena las tuplas en su estado anterior a la modificación (precio_anterior).
-inserted(i): Almacena las tuplas con los nuevos valores ingresados (precio_actualizado).

Ambas tablas se relacionan mediante un INNER JOIN utilizando la clave primaria de la habitación (d.numero = i.numero), lo que permite almacenar en un único renglón el estado previo y posterior.

4_Caso Concreto Aplicado al Sistema del Hotel
Las tarifas de las habitaciones pueden sufrir ajustes a lo largo del tiempo. Para prevenir inconsistencias, el sistema debe registrar en la tabla precio_habitacion cada actualización efectuada sobre la columna precio de la tabla Habitación.

5_Script de Demostración y Resultados Obtenidos

---Creación de la tabla que será modificada---
CREATE TABLE precio_habitacion(
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    num_habitacion INT NOT NULL,
    precio_anterior DECIMAL(10,2),
    precio_actualizado DECIMAL(10,2),
    actualizacion VARCHAR(50),
    empleado VARCHAR(50),
    fecha_modifiacion DATETIME DEFAULT GETDATE()
);
GO


---Implementación de Trigger de Auditoria---
CREATE TRIGGER actualizacion_precios
ON Habitacion
AFTER UPDATE 
AS 
BEGIN 
    SET NOCOUNT ON;
    IF UPDATE(precio)
    BEGIN
        INSERT INTO precio_habitacion(num_habitacion, precio_anterior, precio_actualizado, actualizacion, empleado)
        SELECT 
            d.numero, 
		d.precio, 
		i.precio, 
		'UPDATE', 
		SYSTEM_USER
        FROM deleted d
        INNER JOIN inserted i ON d.numero = i.numero;
    END
END;
GO

---Caso de prueba---
UPDATE Habitacion
SET    precio = 50000
WHERE  numero = 101;
SELECT *
FROM   precio_habitacion;
GO
