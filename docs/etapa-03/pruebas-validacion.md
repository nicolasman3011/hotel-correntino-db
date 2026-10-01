# Pruebas de Validación y Casos de Uso

A continuación se detallan los casos de prueba diseñados para validar las restricciones de la base de datos mediante scripts SQL.

### Caso de Prueba 1: Violación de Integridad Referencial (INSERT)
* **Objetivo:** Comprobar que no se puede hacer una reserva para un huésped que no existe.
* **Acción:** Ejecutar un `INSERT INTO Reserva` utilizando un `id_huesped` que no esté registrado en la tabla `Huesped`.
* **Resultado Esperado:** El motor SQL debe rechazar la inserción mostrando un error de conflicto de `FOREIGN KEY`.

### Caso de Prueba 2: Protección contra Borrado en Cascada (DELETE)
* **Objetivo:** Verificar que el historial de reservas está protegido.
* **Acción:** Intentar ejecutar un `DELETE FROM Habitacion` sobre una habitación que actualmente tiene registros asociados en `Detalle_Reserva`.
* **Resultado Esperado:** Error de restricción referencial. La base de datos impide borrar la habitación porque rompería el historial del detalle de reservas.

### Caso de Prueba 3: Validación de Clave Primaria Duplicada (PK)
* **Objetivo:** Evitar que se registren dos localidades con el mismo identificador.
* **Acción:** Ejecutar un `INSERT INTO Localidad` con un `id_localidad` que ya fue ingresado anteriormente.
* **Resultado Esperado:** Falla en la ejecución por violación de la restricción `PRIMARY KEY`.

### Caso de Prueba 4: Flujo Feliz (Happy Path)
* **Objetivo:** Registrar un circuito completo de reserva exitoso.
* **Acción:** Insertar datos secuencialmente en `Localidad` -> `Persona` -> `Huesped` -> `Empleado` -> `Habitacion` -> `Reserva` -> `Detalle_Reserva` -> `Pago`.
* **Resultado Esperado:** Todas las sentencias se ejecutan correctamente y los datos quedan persistidos y vinculados.
